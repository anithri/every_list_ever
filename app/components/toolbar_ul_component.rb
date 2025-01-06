# frozen_string_literal: true

class ToolbarUlComponent < ViewComponent::Base
  def initialize(condensed: false, **args)
    super
    @condensed = condensed
  end

  def button_classes
    if @condensed
      "*:rounded-full *:py-1 *:px-1 *:text-sm"
    else
      "*:rounded-full *:py-2 *:px-4 *:text-sm"
    end
  end
end
