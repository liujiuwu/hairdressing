# == Schema Information
# Schema version: 20080823070001
#
# Table name: infos
#
#  id                 :integer(11)     not null, primary key
#  title              :string(255)     
#  info_type          :integer(11)     
#  description        :text            
#  name               :string(255)     
#  telephone          :string(255)     
#  mobile             :string(255)     
#  email              :string(255)     
#  address            :string(255)     
#  postcode           :string(255)     
#  period_of_validity :integer(11)     
#  city               :string(255)     
#  hits               :integer(11)     default(0)
#  user_id            :integer(11)     
#  created_at         :datetime        
#  updated_at         :datetime        
#

class Info < ActiveRecord::Base
  belongs_to :user
  #acts_as_taggable

  validates_presence_of     :title,:message => "分类信息标题不能为空，请填写！"
  validates_presence_of     :info_type,:message => "请选择信息类别！"
  validates_presence_of     :period_of_validity,:message => "请选择有效期！"
  validates_presence_of     :description,:message => "分类信息内容不能为空，请填写！"
  validates_presence_of     :name,:message => "联系人不能为空，请填写！"
  validates_presence_of     :telephone,:message => "联系电话不能为空，请填写！"
  validates_presence_of     :mobile,:message => "手机不能为空，请填写！"
  validates_presence_of     :email,:message => "Email不能为空，请填写！"
  validates_presence_of     :address,:message => "联系地址不能为空，请填写！"
  validates_presence_of     :postcode,:message => "邮编不能为空，请填写！"

  validates_length_of        :email,    :within => 10..50,:too_short => "Email地址长度太短，不少于10个字符！",:too_long =>"Email地址长度太长，不多于50个字符！",:if => Proc.new { |u| !u.email.blank? }
  validates_format_of        :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,:message=>"邮件地址格式不正确",:if => Proc.new { |u| !u.email.blank? }

  INFO_TYPES = [["--请选择--",-1],["转让",0],["合作",1],["招聘",2],["求职",3],["优惠活动",4]]
  PERIOD_OF_VALIDITY = [["--请选择--",-1],["3天",3],["7天",7],["15天",15],["30天",30],["60天",60]]
  
  def period_of_validity_name(day)
    mes = ""
    mes << "#{period_of_validity}天 "
    if day <= 0 then
      mes << "<em class=\"fontOrange b\">已过期</em"
    else
      mes << "还剩余 <em class=\"fontOrange b\">#{day}</em> 天"
    end
    return mes
  end
  
  def info_type_name
    meta_contents = MetaContent.find(:all,:conditions => ["meta_type=? and meta_code=?","info_type",info_type])
    meta_contents[0].meta_name unless meta_contents.nil?
  end
  
  def city_name
    city.nil? ? "全国":Area.full_area_name(city)
  end

  def self.info_types
    MetaContent.find(:all,:conditions => ["meta_type=?","info_type"]).map{ |m| [m.meta_name,m.meta_code.to_i]}
  end
  
  def self.period_of_validities
    MetaContent.find(:all,:conditions => ["meta_type=?","info_period_of_validity"]).map{ |m| [m.meta_name,m.meta_code.to_i]}
  end
 
end
