# frozen_string_literal: true

class InvitesController < ApplicationController
  before_action :check_user_registration, :authenticate_user!
  before_action :fetch_current_invite, only: [:accept_invite]
  before_action :fetch_invite_from_params, only: [:create]

  def index
    @invite = Invite.new
  end

  def create
    if @invite.errors.empty?
      flash[:success] = "An invitation has been sent to #{@invite.email}"
      redirect_to root_path
    else
      flash[:danger] = @invite.errors.full_messages.join(', ')
      redirect_to invites_path
    end
  end

  def accept_invite
    if @invite
      @invite.recipient.organizations.push(@invite.organization)
    else
      flash[:danger] = 'Invalid token'
    end
    redirect_to root_path
  end

  private

  def invite_params
    permitted_params = params.require(:invite).permit(invite_attributes)
    permitted_params.merge(sender_id: current_user.id, organization_id: current_org.id)
  end

  def invite_attributes
    %i[email organization_id sender_id]
  end

  def invite_data
    {
        base_url: request.base_url,
        invite_params: invite_params,
        accept_path: accept_invite_path(invite_token: ''),
        new_user_path: new_user_registration_path
    }
  end

  def fetch_invite_from_params
    @invite = Magmonitor::InvitesService.new(invite_data).perform_invitation
  end

  def fetch_current_invite
    @invite = Invite.find_by_token(params[:invite_token])
  end
end
