# frozen_string_literal: true
class RegisteredUsersController < ApplicationController
  def home
    authorize :registered_home_path
  end
end
