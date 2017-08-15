# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: %i[github google_oauth2]

  has_many :memberships
  has_many :organizations, through: :memberships
  has_many :user_groups_users
  has_many :user_groups, through: :user_groups_users

  def registration_finished
    update_attribute :fully_registered, true
  end

  def find_organization(organization_id = '')
    organizations.find_by(slug: organization_id) || organizations.first
  end

  def owner_of?(organization)
    memberships.find_by(organization_id: organization.id).owner?
  end
end
