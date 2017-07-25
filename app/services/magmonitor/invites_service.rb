# frozen_string_literal: true

module Magmonitor
  class InvitesService
    attr_reader :invite_data

    def initialize(invite_data)
      @invite_data = invite_data
    end

    def perform_invitation
      invite = Invite.new(@invite_data[:invite_params])
      if invite.save
        url = if !invite.recipient.nil?
                build_invitation_url(@invite_data[:accept_path], invite.token)
              else
                build_invitation_url(@invite_data[:new_user_path], invite.token)
              end
        InviteMailer.create_invite(invite, url).deliver
      end
      invite
    end

    private

    def build_invitation_url(url, token)
      "#{@invite_data[:base_url]}/#{url}?invite_token=#{token}"
    end
  end
end
