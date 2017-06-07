# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :users, through: :memberships
  has_many :memberships, inverse_of: :organization
  has_many :sites

  include Sluggable
end
