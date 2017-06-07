# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Magmonitor::UserRegistrationService do
  subject { Magmonitor::UserRegistrationService.new(user_params) }

  let(:last_user) { User.last }

  context '#perform' do
    describe 'When registering with google2' do
      let(:user_params) do
        {
            info: {
                name: 'Homer Simpson',
                email: 'homer@simpsons.com',
                image: 'http://super.simpsons.com/avatar/homer.jpg'
            }
        }
      end
      it 'creates new user with specific email and images' do
        subject.perform

        expect(last_user.name).to eql(user_params[:info][:name])
        expect(last_user.email).to eql(user_params[:info][:email])
        expect(last_user.image).to eql(user_params[:info][:image])
      end
    end
  end
end
