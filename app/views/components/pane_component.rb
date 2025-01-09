# frozen_string_literal: true

class PaneComponent < ApplicationComponent
  attr_reader :title_str, :subtitle_str, :classes, :html_opts

  def initialize(title, subtitle = nil, **html_opts)
    @title_str = title
    @subtitle_str = subtitle
    @classes = html_opts.delete(:class) || ""
    @html_opts = html_opts
  end

  def view_template(&content)
    article(class: article_classes, **html_opts) do
      header(class: "px-1 py-1 bg-indigo-800 text-white rounded-t-sm") do
        title
        subtitle
      div class: "h-full w-full p-2 bg-reading-surface-light text-reading-type-dark rounded-b-sm", &content
      end
    end
  end

  def title
    h2(class: "text-2xl font-bold text-center") { title_str }
  end

  def subtitle
    warn '-' * 20 + subtitle_str + '-' * 20
    return '' unless subtitle_str
    div class: "w-full text-center" do
      span(class: "text-center") { subtitle_str }
    end
  end


  private
  def article_classes
    klasses = "bg-indigo-200 border-1 border-indigo-900 flex-auto grow-0 rounded-md container-sm"
    if classes
      klasses += " " + classes
    end
    klasses
  end
end
