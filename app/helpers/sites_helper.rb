# frozen_string_literal: true

module SitesHelper
  def status_badge(http_response)
    result = http_response_mapping[http_response]
    content_tag(:div, result[:text], class: "alert alert-#{result[:color]}")
  end

  def http_response_mapping
    {
        'Net::HTTPInformation' => { text: 'Up', color: 'success' },
        'Net::HTTPSuccess' => { text: 'Up', color: 'success' },
        'Net::HTTPRedirection' => { text: 'Redirect', color: 'info' },
        'Net::HTTPClientError' => { text: 'Error', color: 'warning' },
        'Net::HTTPServerError' => { text: 'Down', color: 'danger' }
    }
  end
end
