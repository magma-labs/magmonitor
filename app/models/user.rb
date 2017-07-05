# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: %i[github google_oauth2]

  has_many :memberships
  has_many :organizations, through: :memberships

  def registration_finished
    update_attribute :fully_registered, true
  end

  def find_organization(organization_id = '')
    organizations.find_by(slug: organization_id) || organizations.first
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.image = auth.info.image
    end
  end
end
