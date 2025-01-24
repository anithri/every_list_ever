# frozen_string_literal: true

class Password < ApplicationForm
  attr_accessor :password, :password_confirmation, :email, :name
end
