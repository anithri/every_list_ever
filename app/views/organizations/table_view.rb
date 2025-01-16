# frozen_string_literal: true

module Organizations
  class TableView < ApplicationView
    attr_reader :orgs, :current_user, :classes, :html_opts

    HEADERS = %w[Name Owner Visible]

    def initialize(orgs, current_user, **html_opts)
      @orgs = orgs
      @current_user = current_user
      @classes = html_opts.delete(:class) || ""
      @html_opts = html_opts
    end

    def view_template
      table class: "table-auto border-separate border-spacing-2 #{classes}", **html_opts do
        thead do
          tr do
            HEADERS.each do |header|
              th { header }
            end
          end
        end
        tbody do
          orgs.each do |org|
            view :organizations, :table_row, org, current_user
          end
        end
      end
    end
  end
end
