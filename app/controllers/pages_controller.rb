class PagesController < ApplicationController
  allow_unauthenticated_access only: %i[ home ]

  def home
    flash.now[:notice] = "Welcome to the home page!"
    flash.now[:alert] = "Login or create a new user."
  end

  def root
    authenticated? ? redirect_to(registered_home_path) : redirect_to(guest_home_path)
  end
end
