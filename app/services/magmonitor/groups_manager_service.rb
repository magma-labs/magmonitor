# frozen_string_literal: true

module Magmonitor
  class GroupsManagerService
    attr_reader :invite_data

    def initialize(invite_data)
      @invite_data = invite_data
    end

    def perform_invitation
      invite = Invite.new(@invite_data[:invite_params])
      if invite.save
        url = build_invitation_url(invite, invite.token)
        InviteMailer.create_invite(invite, url).deliver
      end
      invite
    end

    private

    def build_invitation_url(invite, token)
      if invite.recipient
        "#{@invite_data[:base_url]}/#{@invite_data[:accept_path]}#{token}"
      else
        "#{@invite_data[:base_url]}/#{@invite_data[:new_user_path]}?invite_token=#{token}"
      end
    end
  end
end
