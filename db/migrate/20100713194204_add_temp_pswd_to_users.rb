class AddTempPswdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :temp_pswd, :string
  end

  def self.down
    remove_column :users, :temp_pswd
  end
end
