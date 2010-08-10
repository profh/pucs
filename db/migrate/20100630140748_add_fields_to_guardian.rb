class AddFieldsToGuardian < ActiveRecord::Migration
  def self.up
    add_column :guardians, :is_primary, :boolean
    add_column :guardians, :relationship, :integer
    add_column :guardians, :is_female, :boolean
    add_column :guardians, :ethnicity, :integer
    add_column :guardians, :email, :string
    add_column :guardians, :mobile_phone, :string
    add_column :guardians, :work_phone, :string
    add_column :guardians, :user_id, :integer
    add_column :guardians, :security_form, :boolean
    add_column :guardians, :active, :boolean, :default => true
  end

  def self.down
    remove_column :guardians, :is_primary
    remove_column :guardians, :relationship
    remove_column :guardians, :is_female
    remove_column :guardians, :ethnicity
    remove_column :guardians, :email
    remove_column :guardians, :mobile_phone
    remove_column :guardians, :work_phone
    remove_column :guardians, :user_id
    remove_column :guardians, :security_form
    remove_column :guardians, :active
    
  end
end
