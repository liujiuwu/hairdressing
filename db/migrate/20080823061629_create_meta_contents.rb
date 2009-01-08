class CreateMetaContents < ActiveRecord::Migration
  def self.up
    create_table :meta_contents do |t|
      t.string :meta_name
      t.string :meta_type
      t.string :meta_code
      t.string :remark
    end
  end

  def self.down
    drop_table :meta_contents
  end
end
