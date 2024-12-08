class UserPolicy < ApplicationPolicy
  def initialize(user, event)
    @user  = user
    @event = event
  end

  def index?
    user.admin?
  end

  def new?
    index?
  end

  def create_new_user?
    index?
  end

  def show?
    index?
  end

  def edit?
    index?
  end

  def update?
    index?
  end

  def toggle_active?
    index?
  end

  def destroy?
    index?
  end

  def dash_board?
    true
  end
end
