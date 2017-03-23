# frozen_string_literal: true

class User < ApplicationRecord
  has_many :memberships
  has_many :organizations, through: :memberships

  def registration_finished
    update_attribute :fully_registered, true
  end
end
