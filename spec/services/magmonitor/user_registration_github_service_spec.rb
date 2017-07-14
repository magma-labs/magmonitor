# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Magmonitor::UserRegistration::GithubService do
  subject { Magmonitor::UserRegistration::GithubService.new(user_params) }

  let(:last_user) { User.last }

  context '#persist' do
    describe 'When registering with GitHub' do
      let(:user_params) do
        {
            info: {
                nickname: 'Homer Simpson',
                email: 'homer@simpsons.com',
                image: 'http://super.simpsons.com/avatar/homer.jpg'
            }
        }
      end
      it 'creates new user with specific email and images' do
        subject.persist

        expect(last_user.name).to eql(user_params[:info][:nickname])
        expect(last_user.email).to eql(user_params[:info][:email])
        expect(last_user.image).to eql(user_params[:info][:image])
      end
    end
  end
end
