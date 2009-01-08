class Hairstyles < ActiveRecord::Migration
  def self.up
    create_table :hairstyles do |t|
      t.string :title
      t.string :from
      t.text :content
      t.integer :hits,:default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :hairstyles
  end
end