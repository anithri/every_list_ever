# frozen_string_literal: true

module Organizations
  class TableRowView < ApplicationView
    attr_reader :org, :current_user, :classes, :html_opts

    def initialize(org, current_user,  **html_opts)
      @org = org
      @current_user = current_user
      @classes = html_opts.delete(:class) || ""
      @html_opts = html_opts
    end

    def view_template
      tr class: @classes, **html_opts do
        td { org.name }
        td { org.user.name }
        td { org.visible ? "Yes" : "No" }
        td { org.created_at.to_s }
        td { org.updated_at.to_s }
        td do
          component :toolbar_ul, :row, :condensed do
            li { show_button }
            li { edit_button } if owner?(org)
            li { delete_button } if owner?(org)
          end
        end
      end
    end

    def owner?(org)
      admin? || current_user == org.user
    end

    def admin?
      current_user&.admin?
    end

    def show_button
      component :link_button, org, :info, :condensed, title: "Show User" do
        component :icon, :eye
        whitespace
        plain "Show"
      end
    end

    def edit_button
      component :link_button, edit_organization_path(org), :success, :condensed, title: "Edit User" do
        component :icon, :pen
        whitespace
        plain "Edit"
      end
    end

    def delete_button
      component :link_button, org, :danger, :condensed, title: "Delete User",
                data: { turbo_method: :delete, turbo_confirm: "Are you sure?" } do
        component :icon, :eraser
        whitespace
        plain "Delete"
      end
    end

  end
end
