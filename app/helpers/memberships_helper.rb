# frozen_string_literal: true

module MembershipsHelper
  def membership_class(name)
    "MembershipComponents::#{name.to_s.camelize}".constantize
  end

  def membership(name, *args, **kwargs, &block)
    render membership_class(name).new(*args, **kwargs, &block)
  end
end
