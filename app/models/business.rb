# == Schema Information
# Schema version: 20080823070001
#
# Table name: businesses
#
#  id            :integer(11)     not null, primary key
#  title         :string(255)     
#  description   :text            
#  business_type :string(255)     
#  hits          :integer(11)     default(0)
#  salon_id      :integer(11)     
#  created_at    :datetime        
#  updated_at    :datetime        
#

class Business < ActiveRecord::Base
  belongs_to :salon,:counter_cache => true
  
  validates_presence_of     :title,:message => "商业合作标题不能为空，请填写！"
  validates_presence_of     :description,:message => "商业合作内容不能为空，请填写！"
  validates_length_of       :title, :within => 2..40,:too_short => "商业合作标题长度太短，不少于2个字符！",:too_long =>"商业合作标题长度太长，不多于40个字符！", :if => Proc.new { |f| !f.title.blank? }
  validates_length_of       :description, :within => 2..400,:too_short => "商业合作内容长度太短，不少于2个字符！",:too_long =>"商业合作内容长度太长，不多于400个字符！", :if => Proc.new { |f| !f.description.blank? }
  
end
