# frozen_string_literal: true

Magmonitor::Application.config.action_mailer.delivery_method = :postmark
Magmonitor::Application.config.action_mailer.postmark_settings = {
    api_token: Rails.application.secrets.postmark_api_token
}
