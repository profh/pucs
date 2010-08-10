class AddFieldsToHousehold < ActiveRecord::Migration
  def self.up
    add_column :households, :zip, :string
    add_column :households, :home_phone, :string
    add_column :households, :free_lunch, :boolean
    add_column :households, :status, :integer
    add_column :households, :active, :boolean, :default => true
  end

  def self.down
    remove_column :households, :active
    remove_column :households, :status
    remove_column :households, :free_lunch
    remove_column :households, :home_phone
    remove_column :households, :zip
  end
end
