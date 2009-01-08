# == Schema Information
# Schema version: 20080823070001
#
# Table name: flacks
#
#  id          :integer(11)     not null, primary key
#  name        :string(255)     
#  description :text            
#  hits        :integer(11)     default(0)
#  enable      :boolean(1)      
#  salon_id    :integer(11)     
#  created_at  :datetime        
#  updated_at  :datetime        
#

class Flack < ActiveRecord::Base
  belongs_to :salon,:counter_cache => true
  
  validates_presence_of     :name,:message => "活动信息名称不能为空，请填写！"
  validates_presence_of     :description,:message => "活动信息描述不能为空，请填写！"
  validates_length_of       :name, :within => 2..40,:too_short => "活动信息名称长度太短，不少于2个字符！",:too_long =>"活动信息名称长度太长，不多于40个字符！", :if => Proc.new { |f| !f.name.blank? }
  validates_length_of       :description, :within => 2..400,:too_short => "活动信息描述长度太短，不少于2个字符！",:too_long =>"活动信息描述长度太长，不多于400个字符！", :if => Proc.new { |f| !f.description.blank? }
  
  def self.find_recent(area,count=8)
    find(:all,:select => "flacks.*",:joins => "as flacks inner join salons as salons on flacks.salon_id = salons.id and salons.city like '#{area.code}%'",:limit => count,:order =>'created_at desc')
  end
end
