# frozen_string_literal: true

class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :contact_email
      t.string :slug
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
