# frozen_string_literal: true

class CreateSiteCheckResults < ActiveRecord::Migration[5.1]
  def change
    create_table :site_check_results do |t|
      t.string :raw_response
      t.string :response_code
      t.string :http_response
      t.integer :response_time

      t.integer :check_location_id
      t.integer :site_check_id
      t.timestamps
    end
  end
end
