class CreatePrivacySettings < ActiveRecord::Migration
  def self.up
    create_table :privacy_settings do |t|
      t.integer :household_id
      t.boolean :public_address, :default => true
      t.boolean :public_names, :default => true
      t.boolean :public_children, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :privacy_settings
  end
end
