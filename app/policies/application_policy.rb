# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record, :page

  def initialize(user, record, page)
    @user = user
    @record = record
    @page = page
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

  class Scope
    def initialize(user, scope, page)
      @user = user
      @scope = scope
      @page = page
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope, :page
  end
end
