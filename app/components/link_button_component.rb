# frozen_string_literal: true

class LinkButtonComponent < ViewComponent::Base
  BASE_CLASSES = %w[rounded-md text-white]
  VARIANTS = {
    condensed: %w[py-1 px-1 text-sm],
    normal: %w[py-2 px-2],
    danger: %w[bg-danger],
    info: %w[bg-info],
    success: %w[bg-success],
    warning: %w[g-warning],
  }
  VARIANTS.default = []

  def initialize(variant: nil, path:, label: nil, classes: "", data: {}, title: nil, icon_left: nil, icon_right: nil, condensed: false)
    @variant = variant&.to_sym
    @path = path
    @label = label || title
    @classes = classes
    @data = data
    @title = title || label
    @icon_left = icon_left
    @icon_right = icon_right
    @condensed = condensed ? :condensed : :normal
    @button_classes = button_classes
  end

  def button_classes
    (BASE_CLASSES + VARIANTS[@condensed] + VARIANTS[@variant]).compact.uniq.join(" ") + @classes
  end
end
