class Jobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.boolean :enable,:default => true
      t.integer :hits,:default => 0
      t.integer :salon_id

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
