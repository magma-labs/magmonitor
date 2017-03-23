# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  let(:google_oauth2) do
    {
        provider: 'google_oauth2',
        uid: '123456789',
        info: {
            name: 'John Doe',
            email: 'john@company_name.com',
            first_name: 'John',
            last_name: 'Doe',
            image: 'https://lh3.googleusercontent.com/url/photo.jpg'
        }
    }
  end

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(google_oauth2)
  end

  context 'when using google_auth2' do
    let(:user) { User.find_by email: 'john@company_name.com' }
    it 'creates a new user if not found' do
      get '/auth/google_oauth2'
      follow_redirect!
      expect(user.name).to eq('John Doe')
    end
  end
end
