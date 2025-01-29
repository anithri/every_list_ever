# frozen_string_literal: true
class MembersController < AuthenticationController
  before_action :require_login
  add_breadcrumb "Every List Ever", :root_path

  def home
    authorize :members_home, :home?
    add_breadcrumb "Members Dashboard", :members_home_path
    @memberships = OrganizationMember.where(user: current_user).includes(:organization)
  end
end
