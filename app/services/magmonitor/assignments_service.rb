# frozen_string_literal: true

module Magmonitor
  class AssignmentsService
    attr_reader :user
    attr_reader :group

    def initialize(params)
      @user = User.find(params[:user_id])
      @group = UserGroup.find(params[:group_id])
    end

    def perform_assign_user
      @group.users << @user
      @group
    rescue ActiveRecord::RecordInvalid
      false
    end
  end
end
