# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @user.memberships.first.update_attribute(:role, 'owner')
  end

  describe 'POST create' do
    context 'when user tries to be assigned to an specific group' do
      it 'responds with success when user got assigned correctly' do
        group = FactoryGirl.create(:user_group)
        params =
          {
              user_id: @user.id,
              group_id: group.id
          }
        post '/org/magmalabs/api/v1/assignments', params: params, as: :json
        result = ActiveSupport::JSON.decode(response.body)
        expect(result).to be_truthy
      end

      it 'responds with errors when assignation fails' do
        group = FactoryGirl.create(:user_group)
        group.users << @user
        params =
          {
              user_id: @user.id,
              group_id: group.id
          }
        post '/org/magmalabs/api/v1/assignments', params: params, as: :json
        result = ActiveSupport::JSON.decode(response.body)
        expect(result['success']).to be_falsy
      end
    end
  end
end
