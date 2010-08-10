class CreateHouseholds < ActiveRecord::Migration
  def self.up
    create_table :households do |t|
      t.string :street
      t.string :city
      t.string :state, :default => "PA"

      t.timestamps
    end
  end

  def self.down
    drop_table :households
  end
end
