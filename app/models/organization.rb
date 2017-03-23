# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :users, through: :memberships
  has_many :memberships, inverse_of: :organization
  before_validation :build_slug

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  private

  def build_slug
    self.slug = name.parameterize
  end
end
