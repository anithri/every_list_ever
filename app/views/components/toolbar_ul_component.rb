# frozen_string_literal: true

class ToolbarUlComponent < ApplicationComponent
  def initialize(*args, **kwargs)

  end
  def view_template(&content)
    ul class: "p-0 m-0 w-full flex flex-center", &content
  end
end
