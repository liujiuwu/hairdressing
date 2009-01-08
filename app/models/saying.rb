# == Schema Information
# Schema version: 20080823070001
#
# Table name: sayings
#
#  id         :integer(11)     not null, primary key
#  name       :string(255)     
#  contact    :string(255)     
#  content    :text            
#  created_at :datetime        
#  updated_at :datetime        
#

class Saying < ActiveRecord::Base

  validates_presence_of     :name,:message => "我们怎么称呼您不能为空，请填写！"
  validates_presence_of     :contact,:message => "我们怎么联系您不能为空，请填写！"
  validates_presence_of     :content,:message => "您要说什么？"
  validates_length_of       :content,    :within => 2..500, :too_short => "您要说太少了吧？不少于2个字符！",:too_long =>"说的也太长了，不多于500个字符！",:if => Proc.new { |c| !c.content.blank? }

end
