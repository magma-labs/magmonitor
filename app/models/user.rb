# frozen_string_literal: true

class User < ApplicationRecord
  has_many :memberships
  has_many :organizations, through: :memberships

  def registration_finished
    update_attribute :fully_registered, true
  end

  def find_organization(organization_id = '')
    organizations.find_by(slug: organization_id) || organizations.first
  end
end
