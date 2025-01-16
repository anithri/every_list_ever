# frozen_string_literal: true

module Users
  class TableRowView < ApplicationView

    attr_reader :user, :current_user, :classes, :html_opts

    def initialize(user, current_user, **html_opts)
      @user = user
      @current_user = current_user
      @classes = html_opts.delete(:class) || ""
      @html_opts = html_opts
    end

    def view_template
      tr class: @classes, **html_opts do
        td { user.email_address }
        td { user.name }
        td { user.site_role }
        td { user.visible ? "Yes" : "No" }
        td { user.created_at.to_s }
        td { user.updated_at.to_s }
        td do
          component :toolbar_ul, :row, :condensed do
            li { show_button }
            li { edit_button } if owner?(user)
            li { delete_button } if owner?(user)
          end
        end
      end
    end

    def show_button
      component :link_button, user, :info, :condensed, title: "Show User" do
        component :icon, :eye
        whitespace
        plain "Show"
      end
    end

    def edit_button
      component :link_button, edit_user_path(user), :success, :condensed, title: "Edit User" do
        component :icon, :pen
        whitespace
        plain "Edit"
      end
    end

    def delete_button
      component :link_button, user, :danger, :condensed, title: "Delete User",
                data: { turbo_method: :delete, turbo_confirm: "Are you sure?" } do
        component :icon, :eraser
        whitespace
        plain "Delete"
      end
    end

    def owner?(user)
      admin? || current_user == user
    end

    def admin?
      current_user&.admin?
    end
  end
end
