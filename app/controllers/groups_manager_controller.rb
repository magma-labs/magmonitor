# frozen_string_literal: true

class GroupsManagerController < ApplicationController
  include ReactOnRails::Controller

  def index
    @user_groups = current_org.user_groups
  end

  def new; end

  def create; end

  def show_users
    @users = current_org.users
  end

  def users_view; end

  def destroy; end

  private

  def initialize_store_store
    redux_store('GroupsManagerStore')
  end
end
