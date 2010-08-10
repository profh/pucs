class AddFieldsToPrivacySettings < ActiveRecord::Migration
  def self.up
    add_column :privacy_settings, :public_emails, :boolean, :default => true
    add_column :privacy_settings, :public_demographics, :boolean, :default => true
    add_column :privacy_settings, :public_home_phone, :boolean, :default => true
    add_column :privacy_settings, :public_other_phones, :boolean, :default => true
  end

  def self.down
    remove_column :privacy_settings, :public_other_phones
    remove_column :privacy_settings, :public_home_phone
    remove_column :privacy_settings, :public_demographics
    remove_column :privacy_settings, :public_emails
  end
end
