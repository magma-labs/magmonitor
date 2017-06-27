# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SiteCheckHttpWorker, type: :job do
  context '#perform' do
    let(:site_check) { FactoryGirl.create(:site_check_ok) }
    let(:last_site_check_result) { SiteCheckResult.last }

    describe 'When checking a site that is healthy' do
      context 'and it serves the content' do
        before do
          stub_request(:get, 'https://www.siteok.com/').to_return(status: 200, body: 'ok!')
        end
        it 'detects response ok and saves the result' do
          subject.perform(site_check.id)
          expect(last_site_check_result.http_response).to eql('Net::HTTPOK')
        end
      end

      context 'and it does a redirection' do
        before do
          stub_request(:get, 'https://www.siteok.com/')
              .to_return(status: 302, headers: { 'location' => 'https://www.siteok.com.mx' })
          stub_request(:get, 'https://www.siteok.com.mx/').to_return(status: 200, body: 'Ok!')
        end

        it 'follows the redirection and saves the result' do
          subject.perform(site_check.id)
          expect(last_site_check_result.http_response).to eql('Net::HTTPOK')
        end
      end
    end

    describe 'When checking a site that is not ok' do
      context 'and it returns a bad certificate' do
        before do
          stub_request(:get, 'https://www.siteok.com/')
              .to_raise(OpenSSL::SSL::SSLError.new('Certificate not valid'))
        end

        it 'catches the exception and saves the error' do
          subject.perform(site_check.id)
          expect(last_site_check_result.http_response).to eql('OpenSSL::SSL::SSLError')
        end
      end
    end

    context 'the site returns weird stuff' do
      before do
        stub_request(:get, 'https://www.siteok.com/')
            .to_raise(Net::HTTPBadResponse.new('Site talks in ssl'))
      end

      it 'catches the exception and saves the error' do
        subject.perform(site_check.id)
        expect(last_site_check_result.http_response).to eql('Net::HTTPBadResponse')
      end
    end
  end
end
