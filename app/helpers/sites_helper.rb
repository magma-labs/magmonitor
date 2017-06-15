# frozen_string_literal: true

module SitesHelper
  def status_badge(http_response)
    result = http_response_mapping(http_response.constantize)
    content_tag(:div, result[:text], class: "alert alert-#{result[:color]}")
  end

  def http_response_mapping(klass)
    if klass <= Net::HTTPInformation || klass <= Net::HTTPSuccess
      { text: 'Up', color: 'success' }
    elsif klass <= Net::HTTPRedirection
      { text: 'Redirect', color: 'info' }
    elsif klass <= Net::HTTPClientError || klass <= Net::HTTPBadResponse
      { text: 'Error', color: 'danger' }
    elsif klass <= Net::HTTPServerError
      { text: 'Down', color: 'danger' }
    else
      { text: 'N/A', color: 'danger' }
    end
  end
end
