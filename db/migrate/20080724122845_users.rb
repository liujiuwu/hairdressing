class Users < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string :login
      t.string :logo
      t.string :email
      t.string :crypted_password, :limit => 40
      t.string :salt, :limit => 40
      t.boolean :is_admin,:default => false
      t.string :name
      t.string :user_type
      t.string :whereareyou
      t.text :intro
      t.string :qq
      t.string :msn
      t.string :telephone
      t.datetime :last_login_at
      t.string :remember_token
      t.datetime :remember_token_expires_at

      t.timestamps
    end
  end

  def self.down
    drop_table "users"
  end
end

