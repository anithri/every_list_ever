class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  add_breadcrumb "Every List Ever", :root_path, unless: :is_home_page?

  before_action :assign_current_user
  def assign_current_user
    Current.user = current_user || User.guest
  end

  def is_home_page?
    warn request.inspect
    true
  end
end
