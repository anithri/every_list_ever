# frozen_string_literal: true

class BaseInput
  include Phlex::Variants
  include ComponentsHelper

  # style do
  #   base ""
  #   variants
  #   defaults
  # end

  defaults
  attr_accessor :label, :value

  def initalize(label, model, initial_value, *args, **html_opts)
    @label = label
    @initial_value = initial_value
    @args = args
    @html_opts = html_opts
  end
end
