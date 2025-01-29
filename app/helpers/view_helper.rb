module ViewHelper
  def view_class(controller, name)
    "#{controller.to_s.camelize}::#{name.to_s.camelize}View".constantize
  end

  def view(controller, name, *args, **kwargs, &block)
    render(view_class(controller, name).new(*args, **kwargs), &block)
  end
end