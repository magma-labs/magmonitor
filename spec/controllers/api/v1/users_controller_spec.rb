# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET index' do
    context 'when asking for all users' do
      it 'returns all of them' do
        user = FactoryGirl.create(:user)
        get :index, org_id: user.organization.slug
        response = ActiveSupport::JSON.decode(response.body)
        expect(response[:data].size).to eql(User.count)
      end
    end
  end
end
