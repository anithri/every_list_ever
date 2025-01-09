# frozen_string_literal: true

class LinkButtonComponent < ApplicationComponent
  include Phlex::Rails::Helpers::LinkTo
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
    icon: [],
    nav: %w[bg-transparent text-gray-300 hover:text-white hover:bg-gray-700]
  }.with_indifferent_access
  VARIANTS.default = [].freeze # return an empty array if the key is not found

  attr_reader :path, :variants, :html_opts

  # @param [String] path the path to link to
  # @param [Array<String, Symbol>] variants the variants to apply to the button
  # @param [Hash] html_opts the options to pass to the link
  def initialize(path, *variants, **html_opts)
    @path = path
    @variants = normalize_variants(variants)
    @html_opts = normalize_html_opts(html_opts)
  end

  def view_template(&content)
    link_to path, **html_opts, &content
  end

  private

  # normalize variants and include :normal if :condensed is not included
  # @param [Array<String, Symbol>] variants the variants to normalize
  # @return [Array<String>] the normalized variants
  def normalize_variants(variants)
    variants.join(" ").split(" ").uniq.compact.map(&:to_sym)
    variants.push(:normal) unless variants.include?(:condensed)
    variants
  end

  # normalize the html_opts and update the classes to include classes from the variants
  # @param [Hash] html_opts the options to normalize
  # @return [Hash] the normalized html_opts
  def normalize_html_opts(html_opts)
    klasses = html_opts.delete(:class).to_s.split(/\s+/) || []
    html_opts[:class] = classes(klasses)

    html_opts
  end

  # return the classes to apply to the button, combining BASE_CLASSES, VARIANTS, and user defined classes
  # @param [String, Symbol, Array<String, Symbol>] klasses the classes to apply to the button
  # @return [String] the classes to apply to the button
  def classes(klasses)
    [ BASE_CLASSES, VARIANTS.fetch_values(*variants), klasses ].flatten.compact.uniq.join(" ")
  end


end
