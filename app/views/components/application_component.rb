# frozen_string_literal: true
require 'phlex/slotable'
class ApplicationComponent < Phlex::HTML
  include Phlex::Rails::Helpers::Routes
  include ComponentsHelper
  def current_user
    Current.user
  end

  if Rails.env.development?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end
end
