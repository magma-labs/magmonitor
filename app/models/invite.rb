# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    regexp = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    record.errors[attribute] << (options[:message] || 'is not an email') unless value.match?(regexp)
  end
end

class Invite < ApplicationRecord
  before_create :generate_token
  before_save :check_user_existence
  validate :check_user_organization
  validates :email, presence: true, email: true

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
    org_name = organization.name
    errors.add(:email, "already exists on #{org_name}") if in_organization?(email, org_name)
  end

  def in_organization?(email, organization_name)
    user = User.find_by_email(email)
    user && user.organizations.where(name: organization_name).count.positive?
  end
end
