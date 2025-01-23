# frozen_string_literal: true

class BtnBarComponent < ApplicationComponent
  attr_reader :element
  def initialize(element = 'ul', *args, **kwargs)
    @element = element
  end
  def view_template(&content)
    if element == 'ul'
      ul class: "p-0 m-0 inline-flex rounded-lg", &content
    else
      div class: "p-0 m-0 inline-flex rounded-lg", &content
    end
  end
end
