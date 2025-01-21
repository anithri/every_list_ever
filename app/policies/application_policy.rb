# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def guest?
    user&.guest?
  end

  def member?
    return false if guest?
    user&.member?
  end

  def admin?
    return false if guest?
    user.admin?
  end

  def owner?
    return false if guest?
    return record.user_id == user.id if record.respond_to?(:user)
    record.owner == user if record.respond_to?(:owner)
    false
  end

  def public?
    admin? || owner? || record.visible?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
