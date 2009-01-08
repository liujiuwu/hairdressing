# == Schema Information
# Schema version: 20080823070001
#
# Table name: jobs
#
#  id          :integer(11)     not null, primary key
#  title       :string(255)     
#  description :text            
#  enable      :boolean(1)      default(TRUE)
#  hits        :integer(11)     default(0)
#  salon_id    :integer(11)     
#  created_at  :datetime        
#  updated_at  :datetime        
#

class Job < ActiveRecord::Base
  belongs_to :salon,:counter_cache => true
  
  validates_presence_of     :title,:message => "招聘标题不能为空，请填写！"
  validates_presence_of     :description,:message => "招聘内容不能为空，请填写！"
  validates_length_of       :title, :within => 2..40,:too_short => "招聘标题长度太短，不少于2个字符！",:too_long =>"招聘标题长度太长，不多于40个字符！", :if => Proc.new { |f| !f.title.blank? }
  validates_length_of       :description, :within => 2..400,:too_short => "招聘内容长度太短，不少于2个字符！",:too_long =>"招聘内容长度太长，不多于400个字符！", :if => Proc.new { |f| !f.description.blank? }
  
  
  def self.find_recent(area,count=8)
    find(:all,:select => "jobs.*",:joins => "as jobs inner join salons as salons on jobs.salon_id = salons.id and salons.city like '#{area.code}%'",:limit => count,:order =>'created_at desc')
  end
end
