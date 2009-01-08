require 'active_record/fixtures'

class LoadMetaContentsData < ActiveRecord::Migration
  def self.up
    down
    
    directory = File.join(File.dirname(__FILE__),"dev_data")
    Fixtures.create_fixtures(directory,"meta_contents")
  end

  def self.down
  end
end
