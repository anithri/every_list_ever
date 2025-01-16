# frozen_string_literal: true

class BtnComponents::BaseComponent < ApplicationComponent
  def view_template
    h1 { "BtnComponents::Base" }
    p { "Find me in app/views/components/btn_components/base_component.rb" }
  end
end
