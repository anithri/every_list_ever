# frozen_string_literal: true

module BtnComponents
  class BaseBtn < ApplicationComponent
    include Phlex::Variants
    include Phlex::Rails::Helpers::Routes
    include ComponentsHelper
    include Phlex::Rails::Helpers::LinkTo

    style do
      base "cursor-pointer"
      variants do
        color do
          danger "bg-danger text-white"
          info "bg-info text-white"
          primary "bg-primary text-secondary"
          secondary "bg-secondary text-primary"
          success "bg-success text-white"
          warning "bg-warning text-white"
          text "bg-transparent text-black"
          nav "bg-transparent text-gray-300 hover:text-white hover:bg-gray-700"
        end
        size do
          sm "py-1 px-2 text-sm"
          md "py-2 px-2 text-md"
          lg "py-3 py-3 text-lg"
        end
        shape do
          rounded "rounded-lg"
          bar ""
          round ""
        end
      end
      defaults color: :primary, size: :md, shape: :rounded
    end

    attr_reader :path, :name, :label, :icon, :color, :size, :shape, :classes, :html_opts

    def initialize(path, name = nil, label: nil, icon: nil, color: nil, size: nil, shape: nil, **html_opts)
      @path = path
      @label = normalize_label(name, label)
      warn @label
      @icon = normalize_icon(icon)
      @color = normalize_color(color)
      @size = normalize_size(size)
      @shape = normalize_shape(shape)
      @classes = html_opts.delete(:class)
      @html_opts = normalize_opts(html_opts)
    end

    def view_template
      link_to path, class: final_classes, **html_opts do
        component(:icon, icon) if @icon.present?
        whitespace
        plain label
      end
    end

    private
    def normalize_label(name, lbl)
      return lbl if lbl.present?

      return name unless self.class.const_defined?(:LABEL)
      warn [name, lbl].inspect

      [ self.class.const_get(:LABEL), name.to_s ].compact.join(" ")
    end

    def normalize_icon(icon)
      return icon if icon.present?

      return self.class.const_get(:ICON) if self.class.const_defined?(:ICON)
    end

    def normalize_color(clr)
      return clr unless self.class.const_defined?(:COLOR)

      self.class.const_get(:COLOR)
    end

    def normalize_size(sz)
      return sz unless self.class.const_defined?(:SIZE)

      self.class.const_get(:SIZE)
    end

    def normalize_shape(sh)
      return sh unless self.class.const_defined?(:SHAPE)

      self.class.const_get(:SHAPE)
    end

    def normalize_opts(opts)
      opts
    end

    def final_classes
      build_style(color: @color, size: @size, shape: @shape, extra_classes: @classes)
    end
  end
end
