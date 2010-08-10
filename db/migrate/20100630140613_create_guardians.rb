class CreateGuardians < ActiveRecord::Migration
  def self.up
    create_table :guardians do |t|
      t.string :first_name
      t.string :last_name
      t.integer :household_id

      t.timestamps
    end
  end

  def self.down
    drop_table :guardians
  end
end
