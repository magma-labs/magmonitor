# frozen_string_literal: true

ActiveModelSerializers.config.adapter = :json_api
Rails.application.routes.default_url_options = {
    host: Rails.application.secrets.default_host_name
}
