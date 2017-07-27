# frozen_string_literal: true

class Invite < ApplicationRecord
  before_create :generate_token
  before_validation :check_user_existence
  validate :check_user_organization, on: :create
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User', optional: true
  belongs_to :organization

  def generate_token
    self.token = Digest::SHA1.hexdigest([organization_id, Time.now, rand].join)
  end

  def check_user_existence
    recipient = User.find_by_email(email)
    return unless recipient
    self.recipient_id = recipient.id
  end

  def check_user_organization
    errors.add(:email, "already a member of #{organization.name}") if already_a_member?
  end

  def already_a_member?
    recipient && recipient.organizations.where(name: organization.name).any?
  end
end
