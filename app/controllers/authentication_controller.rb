class AuthenticationController < ApplicationController
  include Pundit::Authorization
  before_action :require_login
  after_action :verify_authorized

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back_or_to(members_home_path)
  end
end
