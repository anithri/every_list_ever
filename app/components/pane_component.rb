# frozen_string_literal: true

class PaneComponent < ViewComponent::Base
  def initialize(title:, subtitle: nil, classes: "")
    @title = title
    @subtitle = subtitle
    @classes = classes
  end
end
