# frozen_string_literal: true

class UserGroupsUser < ApplicationRecord
  belongs_to :user
  belongs_to :user_group
end
