# frozen_string_literal: true

module Api
  module V1
    # User Serializer
    # Main object to return all info related to a user
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :email, :name
      has_many :organizations
    end
  end
end
