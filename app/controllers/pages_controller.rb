class PagesController < ApplicationController
  def root
    current_user ? redirect_to(members_home_path) : redirect_to(guests_home_path)
  end
end
