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

  def index?
    true
  end
end
