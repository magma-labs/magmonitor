# frozen_string_literal: true

# :reek:disabled
class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.references :organization
      t.references :user
      t.boolean :active
      t.string :role

      t.timestamps
    end
  end
end
