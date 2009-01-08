# == Schema Information
# Schema version: 20080823070001
#
# Table name: news
#
#  id         :integer(11)     not null, primary key
#  title      :string(255)     
#  content    :text            
#  hits       :integer(11)     default(0)
#  created_at :datetime        
#  updated_at :datetime        
#

class News < ActiveRecord::Base
  def self.find_recent(count=8)
    News.find(:all,:limit => count,:order =>'created_at desc')
  end
end
