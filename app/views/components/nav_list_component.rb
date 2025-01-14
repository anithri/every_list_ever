# frozen_string_literal: true

class NavListComponent < ApplicationComponent
  include NavLinks

  def initialize(current_user)
    @current_user = current_user
    @links = []
    @types = {
      guest: %i[guest_home login],
      site_user: %i[registered_home show_user organizations logout],
      admin: %i[registered_home show_user users organizations logout]
    }
  end

  def view_template
    ul(class: 'flex flex-col items-center gap-1 text-xl') do |list|
      links.each do |link|
        li { link }
      end
    end
  end

  delegate :admin?, :member?, :guest?, to: :current_user

  def with_link(&content)
    @links << content
  end

  def link_names_for_site_role
    return @types[:admin] if admin?
    return @types[:registered] if registered?

    @types[:guest]
  end

  def links
    link_names_for_site_role.each_with_object([]) { |l, a| a.push(send(l)) }
  end
end
