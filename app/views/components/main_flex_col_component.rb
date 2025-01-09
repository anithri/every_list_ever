# frozen_string_literal: true

class MainFlexColComponent < ApplicationComponent
  DIRECTION = "flex-col"
  def view_template(&content)
    main class: "flex #{DIRECTION} w-full h-full items-center justify-around",&content
  end
end
