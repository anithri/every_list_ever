module ComponentsHelper
  def component(name, *args, **kwargs, &block)
    component = component_class(name)
    render(component.new(*args, **kwargs), &block)
  end

  def component_class(name)
    "#{name.to_s.camelize}Component".constantize
  end

  def view_class(controller, name)
    "#{controller.to_s.camelize}::#{name.to_s.camelize}View".constantize
  end

  def view(controller, name, *args, **kwargs, &block)
    render(view_class(controller, name).new(*args, **kwargs), &block)
  end

  def btn(name, *args, **kwargs)
    render btn_class(name).new(*args, **kwargs)
  end

  def btn_class(name)
    "BtnComponents::#{name.to_s.camelize}".constantize
  end
end
