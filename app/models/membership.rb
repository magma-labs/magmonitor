# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  accepts_nested_attributes_for :organization

  default_scope { order(:user_id) }
  def owner?
    role == 'owner'
  end
end
