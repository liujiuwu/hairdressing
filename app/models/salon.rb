# == Schema Information
# Schema version: 20080823070001
#
# Table name: salons
#
#  id               :integer(11)     not null, primary key
#  name             :string(255)     
#  description      :text            
#  shop_front       :string(255)     
#  address          :string(255)     
#  city             :string(255)     
#  hits             :integer(11)     default(0)
#  user_id          :integer(11)     
#  telephone        :string(255)     
#  traffic          :string(255)     
#  business_hours   :string(255)     
#  fwus_count       :integer(11)     default(0)
#  flacks_count     :integer(11)     default(0)
#  jobs_count       :integer(11)     default(0)
#  businesses_count :integer(11)     default(0)
#  markermap        :string(255)     
#  created_at       :datetime        
#  updated_at       :datetime        
#

class Salon < ActiveRecord::Base
  belongs_to :user
  acts_as_voteable
  acts_as_commentable
  acts_as_textiled :description
  has_many :fwus,:dependent => :destroy
  has_many :flacks,:dependent => :destroy
  has_many :jobs,:dependent => :destroy
  has_many :businesses,:dependent => :destroy
  
  validates_presence_of     :name,:message => "美发店名不能为空，请填写！"
  validates_presence_of     :description,:message => "介绍不能为空，请填写！"
  validates_presence_of     :address,:message => "地址不能为空，请填写！"
  #validates_presence_of     :city,:message => "所在城区不能为空，请填写！"
  validates_presence_of     :telephone,:message => "电话不能为空，请填写！"
  validates_presence_of     :traffic,:message => "交通路线不能为空，请填写！"
  validates_presence_of     :business_hours,:message => "营业时间不能为空，请填写！"
  validates_presence_of     :shop_front,:message => "门面图片不能为空，请上传门面图片！"
  
  validates_file_format_of :shop_front, :in => ["gif", "png", "jpg"]
  validates_filesize_of :shop_front, :in => 15.kilobytes..1.megabyte
  
  file_column :shop_front, :root_path => File.join(RAILS_ROOT, "public/system"), :web_root => 'system/', :magick => { 
    :versions => { 
      :square => {:crop => "1:1", :size => "150x150", :name => "thumb"}
    }
  }
  def self.find_recent(area,count=8)
    find(:all,:conditions =>["city like ?",area.code+"%"],:order => 'salons.created_at desc',:limit => count)
  end
  
  def city_name
    Area.full_area_name(city)
  end
  
  def content
    contact = "<table width='100%'>"
    contact << "<tr><td width='40'>地址：</td><td align='left'>" << address << "</td></tr>"
    contact << "<tr><td>电话：</td><td align='left'>" << telephone << "</td></tr>"
    contact << "</table>"
  end
  
end
