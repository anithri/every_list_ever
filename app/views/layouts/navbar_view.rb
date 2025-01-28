# frozen_string_literal: true

class NavbarView < ApplicationView
  attr_reader :current_user, :is_guest

  def initialize(current_user)
    @current_user = current_user
  end

  def view_template(&breadcrumbs)
    div class: 'w-full bg-main-page-bar text-main-page-bar-text navbar-grid py-1 m-0' do
      div class: "navbar-grid-controls text-center" do
        span(class: "text-xs") { "sidebar controls" }
      end
      div class: "navbar-grid-logo pr-2" do
        component(:icon, :scroll, class: 'fa-md text-amber-300', title: 'EveryListEver')
      end
      div class: "navbar-grid-left" do
        ul class: "list-none p0 inline w-full", &breadcrumbs
      end
      div(class: "navbar-grid-center text-center") { span { "woot" } }
      div(class: "navbar-grid-right text-right pr-2") { span { "prime" } }

    end
  end
end
