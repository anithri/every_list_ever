# frozen_string_literal: true

class MainFlexRowComponent < ApplicationComponent
  DIRECTION = "flex-row"
  def view_template(&content)
    main class: "flex #{DIRECTION} w-full h-full items-center justify-around",&content
  end
end
