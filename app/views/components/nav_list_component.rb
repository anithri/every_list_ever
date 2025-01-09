# frozen_string_literal: true

class NavListComponent < ApplicationComponent
  include NavLinks

  def initialize(current_user)
    @current_user = current_user
    @links = []
  end

  def view_template(&content)
    ul( class: 'flex flex-col items-center gap-1 text-xl', &content)
  end

  delegate :admin?, :member?, :guest?, to: :current_user
  def with_link(&content)
    @links << content
  end
end
