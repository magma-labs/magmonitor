# frozen_string_literal: true

class GroupsManagerController < ApplicationController
  include ReactOnRails::Controller

  def index
    @user_groups = current_org.user_groups
  end

  def new; end

  def create; end

  def show_users
    @users = current_org.user_groups.find(params[:id]).users
    @groups_manager_data = groups_manager_data
  end

  def users_view; end

  def destroy; end

  private

  def initialize_store_store
    redux_store('GroupsManagerStore')
  end

  def groups_manager_data
    {
        groupsManagerData: {
            current_org: current_org,
            group_id: params[:id]
        }
    }
  end
end
