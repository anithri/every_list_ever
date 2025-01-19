# frozen_string_literal: true
class MembersController < AuthenticationController
  before_action :require_login
  def home
    authorize :members_home, :home?
  end
end
