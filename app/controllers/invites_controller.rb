# frozen_string_literal: true

class InvitesController < ApplicationController
  before_action :authenticate_user!, :check_user_registration
  before_action :allowed_to_invite?, only: %i[index create]

  def index
    @invite = Invite.new
  end

  def create
    invite = Magmonitor::InvitesService.new(invite_data).perform_invitation
    if invite.errors.empty?
      redirect_on_invite(root_path, :success, "An invitation has been sent to #{invite.email}")
    else
      redirect_on_invite(invites_path, :danger, invite.errors.full_messages.join(', '))
    end
  end

  def accept_invite
    invite = Invite.find_by_token(params[:invite_token])
    if invite
      invite.recipient.organizations.push(invite.organization)
    else
      flash[:danger] = 'Invalid token'
    end
    redirect_to root_path
  end

  private

  def invite_params
    invite_attributes = %i[email organization_id sender_id]
    permitted_params = params.require(:invite).permit(invite_attributes)
    permitted_params.merge(sender_id: current_user.id, organization_id: current_org.id)
  end

  def invite_data
    {
        base_url: request.base_url,
        invite_params: invite_params,
        accept_path: accept_invite_path(invite_token: ''),
        new_user_path: new_user_registration_path
    }
  end

  def redirect_on_invite(url, message_type, message)
    flash[message_type] = message
    redirect_to url
  end

  def allowed_to_invite?
    return if org_owned_by_current_user?
    redirect_to root_path
  end
end
