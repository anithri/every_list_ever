module ComponentsHelper
  def component(name, *args, **kwargs, &block)
    component = component_class(name)
    render(component.new(*args, **kwargs), &block)
  end

  def component_class(name)
    "#{name.to_s.camelize}Component".constantize
  end

  def submit_classes(color: :success, size: :sm, shape: :bar, extra_classes: nil)
    BtnComponents::BaseBtn.build_style(color:, size:, shape:, extra_classes:)
  end
end

