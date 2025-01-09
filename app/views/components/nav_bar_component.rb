# frozen_string_literal: true

class NavBarComponent < ApplicationComponent
  attr_reader :current_user, :is_guest

  def initialize(current_user)
    @current_user = current_user
    @is_guest = current_user&.blank? || current_user.guest?
  end

  def view_template
    div class: "h-screen w-16 m-0 bg-indigo-900 text-white shadow-lg text-center" do
      nav do
        header do
          ul(class: "flex flex-col items-center gap-1 text-xl") do |u|
            li do
              h1 { "EveryListEver" }
            end
            li { plain avatar }
            li { greeting }
          end
        end

        component :nav_list, current_user do |list|

          if current_user.blank? || current_user.guest?
            list.with_link { list.guest_home }
            list.with_link { list.login }
          elsif current_user.member?
            list.with_link { list.member_home }
            list.with_link { list.show_user }
            list.with_link { list.logout }
          elsif current_user.admin?
            list.with_link { list.member_home }
            list.with_link { list.show_user }
            list.with_link { list.users }
            list.with_link { list.logout }
          end
        end
      end
    end
  end

  def avatar
    return guest_avatar if current_user&.blank? || current_user.guest? || current_user.avatar_url.blank?

    user_avatar
  end

  def user_avatar
    img(
      class: "size-12 rounded-full bg-white text-center",
      src: current_user.avatar_url,
      alt: "Rounded avatar"
    )
  end

  def guest_avatar
    div class: "relative size-12 overflow-hidden bg-gray-100 rounded-full dark:bg-gray-600" do
      svg(
        class: "absolute w-12 h-12 text-gray-400 -left-1",
        fill: "currentColor",
        viewbox: "0 0 20 20",
        xmlns: "http://www.w3.org/2000/svg"
      ) do |s|
        s.path(
          fill_rule: "evenodd",
          d: "M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z",
          clip_rule: "evenodd"
        )
      end
    end

    def greeting
      is_guest? ? "Guest" : current_user.name
    end

  end
end
