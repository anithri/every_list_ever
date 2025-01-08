# frozen_string_literal: true

# A component to render a link styled as a button
class LinkButton2Component < ViewComponent::Base

  attr_reader :variants, :path, :label, :icon_left, :icon_right, :html_opts, :classes, :html_opts

  def initialize(path:, variants: [], label: nil, **html_opts)
    @path = path
    @variants = normalize_variants(variants)
    @label = normalize_label(label) # must be after both normalize_icons and normalize_variants
    (@icon_left, @icon_right, @classes, @html_opts) = normalize_html_opts(html_opts)
    warn '=' * 40
    warn [@icon_left, @icon_right, @classes, @html_opts].inspect
    warn '=' * 40

    @classes = @html_opts.delete(:class)
    html_opts[:class] = button_classes
  end

  # extracts the icons and user defined classes from html_opts
  # @param [Array<Symbol, String, Hash>] opts  the html_opts to normalize
  # @return [<String, Symbol, NilClass>, <String, Symbol, NilClass>, <String>, Hash{[String,Symbol],}] [icon_left, icon_right, classes, html_opts] the icons and classes to use in the button
  def normalize_html_opts(opts)
    (left, right, classes) = [ opts.delete(:icon_left), opts.delete(:icon_right), opts.delete(:class) ]

    return [left, right, classes, opts]
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
   @variants.include?(:icon) && [ @icon_right, @icon_left ].any?(String)
  end

  # todo - could be dragons here - tailwindcss classes being in the wrong order
  # @return [String] the classes to apply to the button
  def button_classes
    (BASE_CLASSES + VARIANTS.fetch_values(*variants)).flatten.compact.uniq.join(" ") + classes.to_s
  end
end
