# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :memberships, inverse_of: :organization
  has_many :users, through: :memberships
  has_many :sites
  has_many :user_groups

  include Sluggable
end
