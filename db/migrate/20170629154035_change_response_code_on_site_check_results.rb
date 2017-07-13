# frozen_string_literal: true

class ChangeResponseCodeOnSiteCheckResults < ActiveRecord::Migration[5.1]
  def change
    change_column :site_check_results, :response_code, 'integer USING CAST(response_code AS integer)'
  end
end
