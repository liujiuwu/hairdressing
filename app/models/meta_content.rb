# == Schema Information
# Schema version: 20080823070001
#
# Table name: meta_contents
#
#  id        :integer(11)     not null, primary key
#  meta_name :string(255)     
#  meta_type :string(255)     
#  meta_code :string(255)     
#  remark    :string(255)     
#

class MetaContent < ActiveRecord::Base

end
