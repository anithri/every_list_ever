# frozen_string_literal: true
class MembersController < ApplicationController
  before_action :require_login
  def home
    authorize :registered_users
  end
end
