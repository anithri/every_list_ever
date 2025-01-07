# frozen_string_literal: true

# A component to render a link styled as a button
class LinkButtonComponent < ViewComponent::Base
  # A list of base classes that are always applied to the button
  # This also white-lists the TailwindCSS classes
  BASE_CLASSES = %w[rounded-md text-white]

  # A list of variants that can be used to style the button, alone or in concert.
  # This also white-lists the TailwindCSS classes
  VARIANTS = {
    condensed: %w[py-1 px-1 text-sm],
    normal: %w[py-2 px-2],
    danger: %w[bg-danger],
    info: %w[bg-info],
    success: %w[bg-success],
    warning: %w[bg-warning],
    primary: %w[bg-primary],
    secondary: %w[bg-secondary],
  }
  VARIANTS.default = [].freeze # return an empty array if the key is not found

  attr_reader :variants, :path, :label, :classes, :icon_left, :icon_right
  # todo - add pass through for remainder of options for link_to.

  def initialize(path, variant = [], label = nil, html_opts: {})
    @path = path
    @variants = normalize_variants(variants)
    @icon_left, @icon_right = extract_icons.first(2) # must be after variants normalize_variants
    @label = normalize_label(label) # must be after both normalize_icons and normalize_variants

    @classes = @html_opts.delete(:class)
  end

  # adjusts the variants from in incoming array to an array of variants to include
  # @param [String,Symbol, Array<String,Symbol>] variants
  # @note :condensed, :normal included control padding and text size
  #        :danger, :warning, :info, :success, :primary, :secondary control background colors and other parts of a skin
  #        :icon sets the button to be an icon only button
  # @return [Array<String>] including :normal if :condensed is not included
  def normalize_variants(variants)
    variants = Array(variants)
    variants.push(:normal) unless variants.include?(:condensed)
    variants
  end

  # returns and removes the values of :icon_left and :icon_right from the variants hash
  # @return [Array<nil,String,Symbol>] of the icons to use in UI
  def extract_icons()
    @_extract_icons ||= [variants.delete(:icon_left), variants.delete(:icon_right)]
  end

  # returns the label if it is set and the button is not an icon only button
  # @param [String,Symbol,NilClass] label
  # return [String,NilClass] the label to use in the button
  def normalize_label(label)
    return nil if icon_only? # requires the icon variant and at least 1 icon to be set
    label.to_s if label.present? # if they set it, use it
  end

  # predicate to check the conditions for an icon only button
  # @return [Boolean] true if variants include :icon and at least one icon is set
  def icon_only?
    @_icon_only ||= @variants.include(:icon) && [ @icon_right, @icon_left ].any?(String)
  end

  # todo - could be dragons here - tailwindcss classes being in the wrong order
  # @return [String] the classes to apply to the button
  def button_classes
    (BASE_CLASSES + VARIANTS.fetch_values(*variants)).compact.uniq.join(" ") + classes
  end
end
