class ApplicationAuthenticateController < ApplicationController
  before_action :require_login
  after_action :verify_authorized
end
