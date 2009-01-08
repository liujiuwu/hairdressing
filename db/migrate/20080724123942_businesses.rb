class Businesses < ActiveRecord::Migration
  def self.up
    create_table :businesses do |t|
      t.string :title
      t.text :description
      t.string :business_type
      t.integer :hits,:default => 0
      t.integer :salon_id

      t.timestamps
    end
  end

  def self.down
    drop_table :businesses
  end
end
