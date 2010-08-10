class AddFieldsToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :grade, :integer
    add_column :students, :dob, :date
    add_column :students, :ethnicity, :integer
    add_column :students, :is_female, :boolean
    add_column :students, :engrade_id, :integer
    add_column :students, :active, :boolean, :default => true
  end

  def self.down
    remove_column :students, :active
    remove_column :students, :engrade_id
    remove_column :students, :is_female
    remove_column :students, :ethnicity
    remove_column :students, :dob
    remove_column :students, :grade
  end
end
