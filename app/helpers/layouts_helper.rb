module LayoutsHelper

  def layouts_class(name)
    "#{name.to_s.camelize}View".constantize
  end

  def layouts(name, *args, **kwargs, &block)
    render layouts_class(name).new(*args, **kwargs), &block
  end

end