class OrganizationPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def index?
    true
  end

  def show?
    return true if @record.visible?
    owner? || admin?
  end

  def create?
    member? || admin?
  end

  def update?
    return true if owner?

    admin?
  end

  def destroy?
    return true if owner?

    admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.none if user.guest?
      return scope.all if user.admin?

      scope.where(visible: true).or(scope.where(user_id: user.id))
    end
  end
end

(admin, member, guest) = [
  User.new(id: 10, membership: 'admin'),
  User.new(id: 11, membership: 'member'),
  User.new(id: 12, membership: 'guest'),
]
(visible_org, invisible_org, incomplete_org) = [
  Organization.new(user_id: 11, visible: true),
  Organization.new(user_id: 11, visible: false),
  Organization.new
]