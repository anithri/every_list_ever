# frozen_string_literal: true

class Users::TableView < ApplicationView
  attr_reader :users

  def initialize(users, **html_options)
    @users = users
    @classes = html_options.delete(:class) || ""
  end

  def view_template
    table(class: "table-auto border-separate border-spacing-2 #{classes}") do
      thead do
        tr do
          th { "Email" }
          th { "Name" }
          th { "Membership" }
          th { "Visibility" }
          th { "Created At" }
          th { "Updated At" }
          th
        end
      end
      tbody do
        whitespace
        @users.each do |user|
          tr do
            td { user.email_address }
            td { user.name }
            td { user.membership }
            td { user.visible ? "Yes" : "No" }
            td { user.created_at }
            td { user.updated_at }
            td do
              whitespace
              render ToolbarUlComponent.new condensed: true do
                li do
                  whitespace
                  plain component :link_button,
                                  user,
                                  :info,
                                  :condensed,
                                  title: "Show User" do
                    whitespace
                    plain component :icon, :eye
                    plain " New User "
                  end
                end
                whitespace
                if Current.user.admin? || Current.user == user
                  li do
                    whitespace
                    plain component :link_button,
                                    edit_user_path(user),
                                    :success,
                                    :condensed,
                                    title: "Edit User" do
                      whitespace
                      plain component :icon, :pen
                      plain " Edit User "
                    end
                  end
                  whitespace
                end
                whitespace
                if Current.user.admin? || Current.user == user
                  li do
                    whitespace
                    plain component :link_button,
                                    user,
                                    :danger,
                                    :condensed,
                                    data: {
                                      turbo_method: :delete,
                                      turbo_confirm: "Are you sure?"
                                    },
                                    title: "Delete User" do
                      whitespace
                      plain component :icon, :eraser
                      plain " Delete User "
                    end
                  end
                  whitespace
                end
                whitespace
              end
            end
          end
          whitespace
        end
      end
    end
  end
end