# frozen_string_literal: true

module Api
  module V1
    # Serializer used to return a minimal version of user data
    # For example: an autocomplete
    class UserGroupSerializer < ActiveModel::Serializer
      attributes :id, :name
      has_many :users, serializer: MinimalUserSerializer
    end
  end
end
