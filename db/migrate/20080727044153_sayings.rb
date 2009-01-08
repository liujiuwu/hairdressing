class Sayings < ActiveRecord::Migration
  def self.up
    create_table :sayings do |t|
      t.string :name
      t.string :contact
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :sayings
  end
end
