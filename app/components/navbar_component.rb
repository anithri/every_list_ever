# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  include ComponentsHelper
  attr_reader :current_user, :greeting

  def initialize(current_user:)
    @current_user = current_user
    @greeting = greeting
  end

  def greeting
    guest? ? "Guest" : current_user.name
  end

  def guest?
    @current_user.blank? || current_user.guest?
  end
end
