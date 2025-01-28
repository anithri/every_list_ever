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

  def layouts_class(name)
    "#{name.to_s.camelize}View".constantize
  end
  def layouts(name, *args, **kwargs, &block)
    render layouts_class(name).new(*args, **kwargs), &block
  end

  def btn(name, *args, **kwargs, &block)
    render btn_class(name).new(*args, **kwargs, &block)
  end

  def btn_class(name)
    "BtnComponents::#{name.to_s.camelize}".constantize
  end

  def submit_classes(color: :success, size: :sm, shape: :bar, extra_classes: nil)
    BtnComponents::BaseBtn.build_style(color:, size:, shape:, extra_classes:)
  end
end

