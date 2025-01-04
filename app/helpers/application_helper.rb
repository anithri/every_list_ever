module ApplicationHelper
  def icon(name, *classes)
    tag.i class: ["fa fa-#{name}", *classes]
  end
end
