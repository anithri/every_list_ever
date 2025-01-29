# frozen_string_literal: true

module CardComponents
  class InfoAside < ApplicationComponent

    attr_reader :attrs,  :opts, :classes

    def initialize(title, aside, *attrs, **opts)
      @attrs = attrs
      @opts = opts
      @classes = opts.delete(:class)

    end

    def view_template(&block)
      div(
        class:
          "inline-grid w-96 grid-cols-3 divide-x rounded-2xl border-[3px] border-purple-950"
      ) do
        div(class: "col-span-2 rounded-l-lg bg-white p-2 text-black") do
          h1(class: "text-center text-2xl") { "Wooticus Prime" }
          div(class: "p1 text left flex flex-row justify-between text-lg") do
            yield
          end
        end
        div(
          class:
            "rounded-r-lg bg-purple-950 text-neutral-700 flex flex-col text-center justify-around"
        ) { h2(class: "text-amber-400 text-lg") { aside } }
      end
    end
  end
end
