# frozen_string_literal: true

class CreateSiteChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :site_checks do |t|
      t.string :name
      t.string :host_name
      t.string :port
      t.string :basic_auth
      t.string :check_type, default: 'http'
      t.string :user_agent
      t.integer :check_rate, default: 300

      t.integer :site_id
      t.timestamps
    end
  end
end
