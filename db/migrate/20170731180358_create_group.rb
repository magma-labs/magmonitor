class CreateGroup < ActiveRecord::Migration[5.1]
  def change
    create_table :user_groups do |t|
      t.string :name
      t.references :organization
    end

    create_join_table :user_groups, :users, primary_key: :id do |t|
      t.index [:user_group_id, :user_id]
    end
  end
end
