# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Magmonitor::GroupsManagerService do
  subject { Magmonitor::GroupsManagerService.new(group_params) }
  context '#perform_assign_user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:group) { FactoryGirl.create(:user_group) }
    let(:group_params) do
      {
          user: user.to_json,
          group: group.to_json
      }
    end

    describe 'When assigning an user to a group' do
      context 'and user doesn\'t exist on the group' do
        it 'saves the record without errors' do
          result = subject.perform_assign_user
          expect(result).to be_truthy
        end
      end

      context 'and user already exists on the group' do
        it 'return false' do
          group.users << user
          result = subject.perform_assign_user
          expect(result).to be_falsy
        end
      end
    end
  end
end
