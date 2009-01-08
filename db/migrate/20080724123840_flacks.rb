class Flacks < ActiveRecord::Migration
  def self.up
    create_table :flacks do |t|
      t.string :name
      t.text :description
      t.integer :hits,:default => 0
      t.boolean :enable
      t.integer :salon_id

      t.timestamps
    end
  end

  def self.down
    drop_table :flacks
  end
end
