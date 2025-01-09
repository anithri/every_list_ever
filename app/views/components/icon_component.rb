# frozen_string_literal: true

class IconComponent < ApplicationComponent
  attr_reader :icon_name, :html_opts, :klasses

  # param [String, Symbol] icon_name the name of the icon to render
  # param [Hash] html_opts the options to pass to the icon tag
  def initialize(icon_name, **html_opts)
    @icon_name = normalize_icon_name(icon_name)
    @html_opts = html_opts
    @klasses = @html_opts.delete(:class)
  end

  def icon_classes
    [ "fa", "fa-#{icon_name.to_s.dasherize}", klasses ].compact.join(" ")
  end

  # renders the icon tag
  def view_template
    i class: icon_classes, **html_opts
  end

  private

  # @param [String, Symbol] name the name of the icon to render
  # @return [String] the name of the icon to render defaulting to "circle-question"
  def normalize_icon_name(name)
    name.blank? ? "circle-question" : name.to_s
  end
end
