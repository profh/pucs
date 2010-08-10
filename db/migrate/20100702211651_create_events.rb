class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime :starting_at
      t.datetime :ending_at
      t.integer :num_volunteers_needed
      t.string :event_name
      t.string :location
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
