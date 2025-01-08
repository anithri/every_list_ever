class PagesController < ApplicationController
  allow_unauthenticated_access only: %i[ home ]
  def home
    flash.now[:notice] = "Welcome to the home page!"
    flash.now[:alert] = "Login or create a new user."
    if authenticated?
      redirect_to members_home_path
    end
  end
end
