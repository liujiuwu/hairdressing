# == Schema Information
# Schema version: 20080823070001
#
# Table name: fwus
#
#  id                 :integer(11)     not null, primary key
#  name               :string(255)     
#  description        :text            
#  price              :float           
#  preferential_price :float           
#  fwu_type           :string(255)     
#  salon_id           :integer(11)     
#  created_at         :datetime        
#  updated_at         :datetime        
#

class Fwu < ActiveRecord::Base
  belongs_to :salon,:counter_cache => true
  
  validates_presence_of     :name,:message => "服务项目名称不能为空，请填写！"
  validates_presence_of     :description,:message => "服务项目描述不能为空，请填写！"
  validates_length_of       :name, :within => 2..20,:too_short => "服务项目名称长度太短，不少于2个字符！",:too_long =>"服务项目名称长度太长，不多于20个字符！", :if => Proc.new { |f| !f.name.blank? }
  validates_length_of       :description, :within => 2..200,:too_short => "服务项目描述长度太短，不少于2个字符！",:too_long =>"服务项目描述长度太长，不多于200个字符！", :if => Proc.new { |f| !f.description.blank? }
  validates_numericality_of :price,:message => "非法的价格格式，请修正！",:if => Proc.new { |f| !f.price.blank? }
  validates_numericality_of :preferential_price,:message => "非法的优惠价格格式，请修正！",:if => Proc.new { |f| !f.preferential_price.blank? }
end
