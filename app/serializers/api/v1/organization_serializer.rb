# frozen_string_literal: true

module Api
  module V1
    # Organization Serializer
    # Returns organization info without relationships
    class OrganizationSerializer < ActiveModel::Serializer
      attributes :id, :name
    end
  end
end
