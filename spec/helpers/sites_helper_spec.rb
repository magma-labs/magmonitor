# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SitesHelper. For example:
#
# describe SitesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SitesHelper, type: :helper do
  context 'status_badge' do
    describe 'when fetching what color and text to render' do
      it 'returns the correct color and text' do
        expect(helper.status_badge('Net::HTTPSuccess')).to include('alert-success')
        expect(helper.status_badge('Net::HTTPInformation')).to include('alert-success')
        expect(helper.status_badge('Net::HTTPRedirection')).to include('alert-info')
        expect(helper.status_badge('Net::HTTPClientError')).to include('alert-warning')
        expect(helper.status_badge('Net::HTTPServerError')).to include('alert-danger')
      end
    end
  end
end
