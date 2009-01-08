# == Schema Information
# Schema version: 20080823070001
#
# Table name: users
#
#  id                        :integer(11)     not null, primary key
#  login                     :string(255)     
#  logo                      :string(255)     
#  email                     :string(255)     
#  crypted_password          :string(40)      
#  salt                      :string(40)      
#  is_admin                  :boolean(1)      
#  name                      :string(255)     
#  user_type                 :string(255)     
#  whereareyou               :string(255)     
#  intro                     :text            
#  qq                        :string(255)     
#  msn                       :string(255)     
#  telephone                 :string(255)     
#  last_login_at             :datetime        
#  remember_token            :string(255)     
#  remember_token_expires_at :datetime        
#  created_at                :datetime        
#  updated_at                :datetime        
#

require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :salons, :dependent => :destroy
  has_many :infos, :dependent => :destroy
  USER_TYPES = [["普通用户","0"],["店主","1"],["设计师","2"]]
  file_column :logo, :root_path => File.join(RAILS_ROOT, "public/system"), :web_root => 'system/', :magick => {
    :versions => {
      :square => {:crop => "1:1", :size => "48x48", :name => "thumb"},
      :screen => {:crop => "1:1", :size => "150x150>", :name => "medium"}
    }
  }
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :login,:message => "用户名不能为空，请填写！"
  validates_presence_of     :email,:message => "Email地址不能为空，请填写！"
  validates_presence_of     :password,:message => "密码不能为空，请填写！", :if => :password_required?
  validates_presence_of     :password_confirmation,:message => "确认密码不能为空，请填写！",:if => :password_required? && Proc.new { |u| !u.password.blank? }
  validates_length_of       :password, :within => 6..12,:too_short => "密码长度太短，不少于6个字符！",:too_long =>"密码长度太长，不多于12个字符！", :if => :password_required?  && Proc.new { |u| !u.password.blank? }
  validates_confirmation_of :password,:message => "密码与确认密码不致，请重新确认密码！",:if => :password_required?
  validates_length_of        :login,    :within => 3..12, :too_short => "用户名长度太短，不少于3个字符！",:too_long =>"用户名长度太长，不多于12个字符！",:if => Proc.new { |u| !u.login.blank? }
  validates_length_of        :email,    :within => 10..50,:too_short => "Email地址长度太短，不少于10个字符！",:too_long =>"Email地址长度太长，不多于50个字符！",:if => Proc.new { |u| !u.email.blank? }
  validates_format_of        :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,:message=>"邮件地址格式不正确",:if => Proc.new { |u| !u.email.blank? }
  validates_format_of        :login, :with => /^[a-zA-Z0-9]+$/, :message => "用户名只能是数字和字母的组合",:if => Proc.new { |u| !u.login.blank? }
  validates_uniqueness_of   :login, :message => "用户名已经被注册，请换一个用户名试试！"
  validates_uniqueness_of   :email, :message => "Email地址已经被注册，请不要重复注册！"
  before_save :encrypt_password

  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  #attr_accessible :login, :email, :password, :password_confirmation
  attr_accessible :login, :name, :email, :password, :password_confirmation, :qq, :msn, :telephone, :intro, :logo,:user_type,:whereareyou

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def self.find_recent(count=8)
    find(:all,:order => 'users.created_at desc',:limit => count)
  end

  def user_type_name
    case(user_type)
    when "0" then "普通用户"
    when "1" then "<span style=\"color:red\">店主</span>"
    when "2" then "设计师"
    end
  end

  def whereareyou_name
    Area.full_area_name(whereareyou)
  end

  protected
  # before filter
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
    self.crypted_password = encrypt(password)
  end

  def password_required?
    crypted_password.blank? || !password.blank?
  end


end
