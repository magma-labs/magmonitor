# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Invites', type: :feature do
  let(:invite) { Invite.new(email: 'newuser@email.com') }
  let(:api_token) { 'POSTMARK_API_TEST' }
  let(:user) do
    User.create!(
      email: 'user@example.org',
      password: 'very-secret',
      fully_registered: true
    )
  end
  let(:invite_params) do
    {
        email: 'newuser@email.com',
        organization_id: 1,
        sender_id: 1
    }
  end

  let(:invite_data) do
    {
        base_url: 'http://127.0.0.1:300/',
        invite_params: invite_params,
        accept_path: accept_invite_path(invite_token: ''),
        new_user_path: new_user_registration_path
    }
  end

  let(:organization) do
    Organization.new(
      id: 1,
      name: 'MagmaLabs',
      contact_email: 'magmonitor@magmalabs.io',
      slug: 'magmalabs',
      active: true
    )
  end

  before do
    ActionMailer::Base.postmark_settings = { api_token: api_token }
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end

  after(:all) do
    sign_out :user
  end

  context '#create' do
    describe 'When inviting a non registered user' do
      it 'creates a new invitation with a valid email' do
        user.organizations.push(organization)
        user.save
        sign_in user
        visit '/invites'
        fill_in 'invite[email]', with: 'newuser@email.com'
        click_on 'Send'
        expect(page).to have_content('An invitation has been sent to newuser@email.com')
      end

      it 'shows errors when invalid email is submited' do
        user.organizations.push(organization)
        user.save
        sign_in user
        visit '/invites'
        fill_in 'invite[email]', with: 'invalidemail.com'
        click_on 'Send'
        expect(page).to have_content('Email is not an email')
      end
    end
  end
end
