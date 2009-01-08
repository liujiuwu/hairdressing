class Salons < ActiveRecord::Migration
  def self.up
    create_table :salons do |t|
      t.string :name
      t.text :description
      t.string :shop_front
      t.string :address
      t.string :city
      t.integer :hits
      t.integer :user_id
      t.string :telephone
      t.string :traffic
      t.string :business_hours
      t.integer :hits,  :default => 0
      t.integer :fwus_count, :default => 0
      t.integer :flacks_count, :default => 0
      t.integer :jobs_count, :default => 0
      t.integer :businesses_count, :default => 0
      t.string :markermap

      t.timestamps
    end
  end

  def self.down
    drop_table :salons
  end
end
