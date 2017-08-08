# frozen_string_literal: true

module Api
  module V1
    # Serializer used to return a minimal version of user data
    # For example: an autocomplete
    class MinimalUserSerializer < ActiveModel::Serializer
      attributes :id, :email, :name, :image
    end
  end
end
