class EventPolicy < ApplicationPolicy
  def initialize(user, event)
    @user  = user
    @event = event
  end

  def index?
    true
  end
end
