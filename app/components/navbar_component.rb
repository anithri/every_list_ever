# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
    @greeting = greeting
  end

  def greeting
    guest? ? "Guest" : @user.name
  end

  def guest?
    @user.nil? || @user.guest?
  end
end
