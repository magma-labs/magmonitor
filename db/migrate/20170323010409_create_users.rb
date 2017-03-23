# frozen_string_literal: true

# :reek:disabled
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, default: nil
      t.string :email, default: nil
      t.string :image, default: nil
      t.boolean :fully_registered, default: false
      t.timestamps
    end
  end
end
