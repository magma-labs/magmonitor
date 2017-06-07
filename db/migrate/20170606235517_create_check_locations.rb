# frozen_string_literal: true

class CreateCheckLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :check_locations do |t|
      t.string :name

      t.timestamps
    end

    create_table :sites_check_locations do |t|
      t.references :site
      t.references :check_location

      t.timestamps
    end
  end
end
