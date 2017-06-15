# frozen_string_literal: true

FactoryGirl.define do
  factory :site_check do
    name FFaker::Venue.name
    check_type 'http'
    user_agent 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5)'

    trait :site_ok do
      target_url 'https://www.siteok.com'
    end
    trait :site_without_ssl do
      target_url 'http://www.withoutssl.com'
    end

    association :site
    after(:create) do |site_check|
      site_check.check_locations << CheckLocation.first
    end
  end

  factory :site_check_ok, parent: :site_check do
    site_ok
  end

  factory :site_check_without_ssl, parent: :site_check do
    site_without_ssl
  end
end
