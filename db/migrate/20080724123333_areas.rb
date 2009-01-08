class Areas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.string :code
      t.string :name
    end
  end

  def self.down
    drop_table :areas
  end
end
