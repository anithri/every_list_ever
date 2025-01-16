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
          component :toolbar_ul, :row, :sm do
            li { show_button }
            li { edit_button } if owner?(user)
            li { delete_button } if owner?(user)
          end
        end
      end
    end

    def show_button
      btn :show, user, :user, size: :sm, title: "Show User"
    end

    def edit_button
      btn :edit, edit_user_path(user), :user,size: :sm, title: "Edit User"
    end

    def delete_button
      btn :delete, user, :user, size: :sm, title: "Delete User"
    end

    def owner?(user)
      admin? || current_user == user
    end

    def admin?
      current_user&.admin?
    end
  end
end
