class CreateAdministrators < ActiveRecord::Migration
  def self.up
    create_table :administrators do |t|
      t.string :first_name
      t.string :last_name
      t.integer :user_id
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :administrators
  end
end
