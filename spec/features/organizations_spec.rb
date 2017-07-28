# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Organizations', type: :feature do
  let(:user) do
    User.create!(
      email: 'user@example.org',
      password: 'very-secret',
      fully_registered: true,
      organizations: [FactoryGirl.create(:organization, name: 'MagmaLabs')]
    )
  end
  before do
    sign_in user
    user.memberships.first.update_attribute(:role, 'owner')
  end

  context '#new' do
    describe 'When trying to create a new organiation with a fully registered user' do
      it 'loads the `application` layout' do
        visit new_registration_flow_path
        expect(page).to have_selector('#mainNav')
      end
    end
  end
end
