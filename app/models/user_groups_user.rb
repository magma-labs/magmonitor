# frozen_string_literal: true

class UserGroupsUser < ApplicationRecord
  belongs_to :user
  belongs_to :user_group

  validates_uniqueness_of :user_id, scope: :user_group_id
end
