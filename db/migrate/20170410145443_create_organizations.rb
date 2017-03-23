# frozen_string_literal: true

# :reek:disabled
class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :contact_email
      t.string :slug
      t.boolean :active

      t.timestamps
    end
  end
end
