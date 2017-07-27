# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  accepts_nested_attributes_for :organization

  def owner?
    role == 'owner'
  end
end
