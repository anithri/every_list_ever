# frozen_string_literal: true

module MembershipComponents
  class Base < ApplicationComponent

    attr_reader :memberships, :current_user, :args, :opts

    def initialize(memberships, current_user, *args, **opts)
      @memberships = memberships
    end
  end
end