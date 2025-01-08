# frozen_string_literal: true

class FlashMessageComponent < ApplicationComponent
  MSG_TYPES = {
    alert: "bg-danger-light border border-danger-dark text-danger-dark",
    notice: "bg-info-light border border-info-dark text-info-dark",
  }.with_indifferent_access
  MSG_TYPES.default = "".freeze

  MSG_TYPE_ICONS = {
    alert: "exclamation-circle",
    notice: "info-circle",
  }

  attr_reader :flash

  def initialize(flash)
    @flash = flash
    super()
  end

  def view_template(&block)
    div class: "relative top-2 left-0 right-0 flex flex-col items-center justify-center" do
      flash.each do |type, msg|
        render_alert(type, msg)
      end
    end
  end

  def render_alert(type, msg)
    div class: "#{MSG_TYPES[type]} text-inf-dark px-4 py-3 rounded relative", role: "alert" do
      span(class: "block sm:inline") { msg }
      span class: "absolute top-0 bottom-0 right-0 px-4 py-3" do
        i class: "fas fa-#{MSG_TYPE_ICONS[type]} mr-2"
      end
      span
    end
  end
end