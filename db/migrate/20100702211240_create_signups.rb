class CreateSignups < ActiveRecord::Migration
  def self.up
    create_table :signups do |t|
      t.integer :guardian_id
      t.integer :event_id
      t.boolean :attended
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :signups
  end
end
