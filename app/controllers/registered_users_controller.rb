# frozen_string_literal: true
class RegisteredUsersController < ApplicationController
  def home
    authorize :registered_users
  end
end
