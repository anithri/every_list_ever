module ApplicationHelper
  def icon(name, *classes)
    tag.i class: ["fa fa-#{name}", *classes]
  end

  def component(name, *args, **kwargs, &block)
    component = name.to_s.camelize.constantize::Component
    render(component.new(*args, **kwargs), &block)
  end
end
