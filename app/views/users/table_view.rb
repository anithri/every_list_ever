# frozen_string_literal: true

module Users
  class TableView < ApplicationView
    attr_reader :users, :current_user

    HEADERS = %w[Email Name SiteRole Visibility].push('').freeze
    def initialize(users, current_user,  **html_opts)
      @users = users
      @classes = html_opts.delete(:class) || ""
      @html_opts = html_opts
    end

    def view_template
      table(class: "table-auto border-separate border-spacing-2 #{classes}") do
        thead do
          tr do
            HEADERS.each do |header|
              th { header }
            end
          end
        end
        tbody do
          @users.each do |user|
            view :users, :table_row, user, current_user
          end
        end
      end
    end
  end
end
