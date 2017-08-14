# frozen_string_literal: true

module Magmonitor
  class GroupsManagerService
    attr_reader :data

    def initialize(groups_params)
      @data = groups_params
    end

    def perform_assign_user
      @data[:group].users << @data[:user] unless @data[:group].users.include?(@data[:user])
    end
  end
end
