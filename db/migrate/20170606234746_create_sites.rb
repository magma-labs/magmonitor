# frozen_string_literal: true

class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :slug
      t.integer :organization_id
      t.timestamps
    end
  end
end
