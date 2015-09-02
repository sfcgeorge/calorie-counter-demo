class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.none
      end
    end
  end

  def index?
    user.admin?
  end

  def show?
    admin_or_owner
  end

  def logout?
    admin_or_owner
  end

  def update?
    admin_or_owner
  end

  def destroy?
    admin_or_owner
  end

  private

  def admin_or_owner
    user.admin? || user == record
  end
end
