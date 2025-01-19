class UserPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5
  def index?
    ! guest?
  end

  def show?
    admin? || owner?
  end

  def create?
    guest? || admin?
  end

  def update?
    admin? || owner?
  end

  def destroy?
    admin?
  end

  def owner?
    return false if user.guest?
    user == record
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      return scope.none if user.guest?
      return scope.all if user.admin?

      scope.visible.or(scope.where(id: user.id))
    end
  end
end
