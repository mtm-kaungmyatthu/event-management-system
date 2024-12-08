class EventPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def list
      if user.admin?
        Event.all
      else
        user.events
      end
    end

    def owner_list
      user.events
    end
  end

  def initialize(user, event)
    @user  = user
    @event = event
  end

  def index?
    true
  end

  def show?
    user.admin? ? true : event.user == user
  end

  def new?
    user.admin?
  end

  def create?
    true
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  def register?
    show?
  end

  def toggle_active?
    show?
  end
end
