class PagesController < ApplicationController
  allow_unauthenticated_access only: %i[ home ]
  def home
    if authenticated?
      redirect_to members_home_path
    end
  end
end
