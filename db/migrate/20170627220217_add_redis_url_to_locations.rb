class AddRedisUrlToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :check_locations, :redis_url, :string
  end
end
