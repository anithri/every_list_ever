module CardHelper
  def card_class(name)
    "CardComponents::#{name.to_s.camelize}".constantize
  end

  def card(name, *args, **kwargs, &block)
    render card_class(name).new(*args, **kwargs, &block)
  end

end