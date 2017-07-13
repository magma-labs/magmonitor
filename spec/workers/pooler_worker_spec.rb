# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PoolerWorker, type: :worker do
  context '#perform' do
    let(:site) { FactoryGirl.create(:site) }
    describe 'when running pooler worker in a specific data center' do
      context 'and the check rate is met' do
        before do
          Timecop.freeze(Time.local(1990))
          ENV['CHECK_LOCATION_NAME'] = CheckLocation.first.name
          FactoryGirl.create(:site_check_ok, site: site, check_rate: 60)
        end

        after do
          Timecop.return
        end

        it 'enqueues another job every minute' do
          expect do
            subject.perform
          end.to change(SiteCheckHttpWorker.jobs, :size).by(1)
        end
      end
    end
  end
end
