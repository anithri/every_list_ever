# frozen_string_literal: true

class MainFlexComponent < ApplicationComponent
  attr_reader :direction, :classes, :html_opts

  def initialize(is_row= false, **html_opts)
    @direction = is_row ? "flex-row" : "flex-col"
    @classes = html_opts.delete(:class)
    @html_opts = html_opts
  end

  def view_template(&content)
    main class: "flex #{direction} w-full h-full items-center justify-around #{classes}", **html_opts, &content
  end
end
