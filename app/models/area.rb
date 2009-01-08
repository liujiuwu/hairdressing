# == Schema Information
# Schema version: 20080823070001
#
# Table name: areas
#
#  id   :integer(11)     not null, primary key
#  code :string(255)     
#  name :string(255)     
#

class Area < ActiveRecord::Base
  
  def self.full_area_name(code)
    name = ""
    if !code.nil?
      [2,4,6].each do |level|
        area = Area.find(:first,:conditions => ["code=?",code.slice(0,level)])
        name << area.name << " " unless area.nil?
        break if code.length==level
      end
    end
    name
  end
  
end
