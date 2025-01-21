# frozen_string_literal: true

module Organizations
  class TableRowView < ApplicationView
    attr_reader :org, :current_user, :classes, :html_opts

    def initialize(org, current_user, **html_opts)
      @org = org
      @current_user = current_user
      @classes = html_opts.delete(:class) || ""
      @html_opts = html_opts
    end

    def view_template
      tr class: @classes, **html_opts do
        td { org.name }
        td { org.owner.name }
        td { org.visible ? "Yes" : "No" }
        td { org.created_at.to_s }
        td { org.updated_at.to_s }
        td do
          component :btn_bar, :row, :condensed do
            show_button
            edit_button if owner?(org)
            delete_button if owner?(org)
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
      btn :show, org, :Org, size: :sm, shape: :bar, title: "Show Organizationr"
    end

    def edit_button
      btn :edit, edit_organization_path(org), :org, size: :sm, shape: :bar, title: "Edit Organization"
    end

    def delete_button
      btn :delete, org, :org, size: :sm, shape: :bar, title: "Delete Organization"
    end
  end
end
