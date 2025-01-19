class Current < ActiveSupport::CurrentAttributes
  attribute :user
  def guest
    @guest ||= User.guest
  end
  def guest?
    !user
  end
end
