class EventPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope

    def list
      unless user.admin?
        event.all
      else
        user.events
      end.page(page).per(10)
    end
  end

  def index?
    true
  end
end
