# frozen_string_literal: true

class BtnBarComponent < ApplicationComponent
  def initialize(*args, **kwargs)

  end
  def view_template(&content)
    ul class: "p-0 m-0 inline-flex rounded-lg", &content
  end
end
