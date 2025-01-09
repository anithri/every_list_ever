# frozen_string_literal: true

class NavBarComponent < ApplicationComponent
  attr_reader :current_user, :is_guest

  def initialize(current_user)
    @current_user = current_user
  end

  def view_template
    div class: "h-screen w-24 m-0 pt-4 bg-indigo-900 text-white shadow-lg text-center" do
      nav do
        header do
          ul(class: "flex flex-col items-center gap-6 text-xl") do
            li do
              h1(class: "text-amber-400") { component(:icon, :scroll, class: 'fa-xl', title: 'EveryListEver') }
            end
            li do
              avatar
              span { current_user.name }
            end
          end
        end

        component :nav_list, current_user
      end
    end
  end

  def avatar
    return guest_avatar if current_user&.blank? || current_user.guest? || current_user.avatar_url.blank?

    user_avatar
  end

  def user_avatar
    img(
      class: "size-16 rounded-full bg-white text-center",
      src: current_user.avatar_url,
      alt: "Rounded avatar"
    )
  end

  def guest_avatar
    div class: "relative size-16 overflow-hidden bg-gray-100 rounded-full dark:bg-gray-600" do
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
      current_user.name
    end

  end
end
