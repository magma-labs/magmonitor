# frozen_string_literal: true

class UserGroup < ApplicationRecord
  belongs_to :organization
  has_many :user_groups_users
  has_many :users, through: :user_groups_users
end
