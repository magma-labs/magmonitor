# frozen_string_literal: true

class RegistrationFlowController < ApplicationController
  skip_before_action :check_user_registration

  layout 'public'

  def new
    @membership = current_user.memberships.new
    @membership.build_organization
  end

  def create
    @membership = current_user.memberships.create(member_params)
    if @membership.valid?
      current_user.registration_finished
      redirect_to root_url
    else
      flash[:danger] = @membership.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def member_params
    permitted_params = params.require(:membership).permit(org_attributes)
    permitted_params.merge(active: true, role: 'owner')
  end

  def org_attributes
    { organization_attributes: %i[name contact_email] }
  end
end
