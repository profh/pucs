class RemoveEmailFromGuardian < ActiveRecord::Migration
  def self.up
    remove_column :guardians, :email
  end

  def self.down
    add_column :guardians, :email, :string
  end
end
