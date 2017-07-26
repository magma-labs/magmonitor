# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Invites', type: :feature do
  let(:invite) { Invite.new(email: 'newuser@email.com') }
  let(:api_token) { 'POSTMARK_API_TEST' }
  let(:user) do
    User.create!(
      email: 'user@example.org',
      password: 'very-secret',
      fully_registered: true,
      organizations: [FactoryGirl.create(:organization, name: 'MagmaLabs')]
    )
  end
  let(:another_user) do
    User.create!(
      email: 'another_user@example.org',
      password: 'very-secret',
      fully_registered: true,
      organizations: [FactoryGirl.create(:organization, name: 'Another org')]
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
  let(:invite) do
    Invite.create!(
      email: 'invited_user@user.com',
      organization_id: user.organizations.first.id,
      sender_id: user.id,
      recipient_id: nil
    )
  end

  before do
    ActionMailer::Base.postmark_settings = { api_token: api_token }
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    sign_in user
    user.memberships.first.update_attribute(:role, 'owner')
  end

  after(:all) do
    sign_out :user
  end

  context '#create' do
    describe 'When inviting a non registered user' do
      it 'creates a new invitation with a valid email' do
        visit '/invites'
        fill_in 'invite[email]', with: 'newuser@email.com'
        click_on 'Send'
        expect(page).to have_content('An invitation has been sent to newuser@email.com')
      end

      it 'shows errors when invalid email is submited' do
        visit '/invites'
        fill_in 'invite[email]', with: 'invalidemail.com'
        click_on 'Send'
        expect(page).to have_content('Email is not an email')
      end
    end
    describe 'When inviting a user already registered' do
      it 'shows error when user already exists on the organization' do
        visit '/invites'
        fill_in 'invite[email]', with: user.email
        click_on 'Send'
        expect(page).to have_content('Email already exists on MagmaLabs')
      end
      it 'creates a new invitation for a registered user' do
        visit '/invites'
        fill_in 'invite[email]', with: another_user.email
        click_on 'Send'
        expect(page).to have_content("An invitation has been sent to #{another_user.email}")
      end
    end
    describe 'When trying to create an invite' do
      it 'but current user is not an organization owner' do
        user.memberships.first.update_attribute(:role, nil)
        visit '/invites'
        expect(page).not_to have_content('Invites')
      end
    end
  end
  context '#accept_invite' do
    describe 'accepts an invitation' do
      it 'with valid token and not registered user' do
        invite.token = 'invite-with-valid-token'
        invite.save
        logout(:user)
        visit "/users/sign_up?invite_token=#{invite.token}"
        fill_in 'Password', with: '12345678'
        fill_in 'Password confirmation', with: '12345678'
        click_on 'Sign up'
        expect(page).to have_content('Welcome! You have signed up successfully')
        # visit "/invites/accept_invite?invite_token=#{invite.token}"
      end
      it 'with valid token and user already registered' do
        invite.email = another_user.email
        invite.token = 'invite-with-valid-token'
        invite.recipient = another_user
        invite.save
        visit "/invites/accept_invite?invite_token=#{invite.token}"
        expect(page).to have_content('Magmonitor, yet another monitoring tool')
      end
      it 'with invalid token and user already registered' do
        invite.email = another_user.email
        invite.recipient = another_user
        invite.save
        invite.token = 'invalid-token'
        visit "/invites/accept_invite?invite_token=#{invite.token}"
        expect(page).to have_content('Invalid token')
      end
    end
  end
end
