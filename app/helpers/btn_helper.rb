module BtnHelper
  def btn(name, *args, **kwargs, &block)
    render btn_class(name).new(*args, **kwargs, &block)
  end

  def btn_class(name)
    "BtnComponents::#{name.to_s.camelize}".constantize
  end
end