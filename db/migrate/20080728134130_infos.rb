class Infos < ActiveRecord::Migration
  def self.up
    create_table :infos do |t|
      t.string :title
      t.integer :info_type
      t.text :description
      t.string :name
      t.string :telephone
      t.string :mobile
      t.string :email
      t.string :address
      t.string :postcode
      t.integer :period_of_validity
      t.string :city
      t.integer :hits,:default => 0
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :infos
  end
end
