# frozen_string_literal: true

module Magmonitor
  class GroupsManagerService
    attr_reader :data
    attr_reader :params

    def initialize(groups_params)
      @params = groups_params
      @data =
        {
            user: User.find(parse_object(:user)),
            group: UserGroup.find(parse_object(:group))
        }
    end

    def perform_assign_user
      if !@data[:group].users.include?(@data[:user])
        @data[:group].users << @data[:user]
      else
        false
      end
    end

    def parse_object(symbol)
      object = JSON.parse(@params[symbol])
      object['id']
    end
  end
end
