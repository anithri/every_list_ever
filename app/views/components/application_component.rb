# frozen_string_literal: true
require 'phlex/slotable'
require "tailwind_merge"
class ApplicationComponent < Phlex::HTML
  include Phlex::Rails::Helpers::Routes
  include ComponentsHelper
  def current_user
    Current.user
  end

  def merger
    @merger ||= TailwindMerge::Merger.new
  end

  def cn ()
    merger.merge
  end

  if Rails.env.development?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end
end
