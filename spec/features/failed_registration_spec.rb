# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :feature do
  let(:google_oauth2) do
    {
        provider: 'google_oauth2',
        uid: '123456789',
        info: {
            name: 'Test Doe',
            email: 'test@company_name.com',
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

  context 'When creates an user' do
    let(:user) { User.find_by email: 'test@company_name.com' }
    it 'with invalid oauth credentials' do
      OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
      visit '/users/auth/google_oauth2'
      # follow_redirect!
      expect(page).to have_content('You need to sign in or sign up before continuing')
    end
  end

  context 'When creates an user and register an organization' do
    let(:user) { User.find_by email: 'test@company_name.com' }
    it 'with invalid values' do
      visit '/users/auth/google_oauth2'
      # follow_redirect!
      expect(user.name).to eq('Test Doe')
      # follow_redirect!
      visit '/registration_flow/new'
      fill_in 'Organization Name', with: ''
      fill_in 'Primary contact email', with: 'not-an-email'
      click_on 'Create'

      user.reload
      expect(page).to have_content('Organization name can\'t be blank')
    end
  end
end
