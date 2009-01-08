class Fwus < ActiveRecord::Migration
  def self.up
    create_table :fwus do |t|
      t.string :name
      t.text :description
      t.float :price
      t.float :preferential_price
      t.string :fwu_type
      t.integer :salon_id

      t.timestamps
    end
  end

  def self.down
    drop_table :fwus
  end
end
