# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @user.memberships.first.update_attribute(:role, 'owner')
  end

  describe 'GET index' do
    context 'when asking for all users' do
      it 'returns all of them' do
        get '/org/magmalabs/api/v1/users'
        response = ActiveSupport::JSON.decode(body)
        expect(response['data'].size).to eql(User.count)
      end
    end
  end

  describe 'GET autocomplete' do
    context 'when asking for specific users' do
      it 'returns users that matches with the name' do
        get "/org/magmalabs/api/v1/users/autocomplete?keyword=#{@user.name}"
        response = ActiveSupport::JSON.decode(body)
        expect(response['data'][0]['attributes']['name']).to eql(@user.name)
      end

      it 'returns users that matches with the email' do
        get "/org/magmalabs/api/v1/users/autocomplete?keyword=#{@user.email}"
        response = ActiveSupport::JSON.decode(body)
        expect(response['data'][0]['attributes']['email']).to eql(@user.email)
      end
    end
  end
end
