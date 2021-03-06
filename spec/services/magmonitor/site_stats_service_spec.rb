# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Magmonitor::SiteStatsService do
  subject { Magmonitor::SiteStatsService.new(site) }

  let(:site) { FactoryGirl.create(:site) }
  let(:check_location) { CheckLocation.first }
  let(:common_params) { { site_check: site_check, check_location: check_location } }
  let(:site_check) do
    FactoryGirl.create(:site_check_ok, site: site, check_locations: [check_location])
  end

  context '#uptime_since' do
    describe 'when asking for how many percentage it has been up' do
      context 'and it has been 1 up and 1 down' do
        before do
          FactoryGirl.create(:bad_site_check_result, common_params)
          FactoryGirl.create(:good_site_check_result, common_params)
        end

        it 'returns 50.0' do
          expect(subject.uptime_since).to be(50.0)
        end
      end

      context 'and it has been 2 ups' do
        before do
          FactoryGirl.create(:good_site_check_result, common_params)
          FactoryGirl.create(:good_site_check_result, common_params)
        end

        it 'returns 100.0' do
          expect(subject.uptime_since).to be(100.0)
        end
      end

      context 'and it has been own downs' do
        before do
          FactoryGirl.create(:bad_site_check_result, common_params)
          FactoryGirl.create(:bad_site_check_result, common_params)
        end

        it 'returns 0.0' do
          expect(subject.uptime_since).to be(0.0)
        end
      end
    end
  end
end
