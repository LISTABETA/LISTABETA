class StartupPolicy < ApplicationPolicy
  attr_reader :user, :startup

  def initialize(user, startup)
    @user = user
    @startup = startup
  end

  def show?
    startup.published? || startup.user == @user
  end

  def create?
    @user
  end

  def edit?
    startup.draft? && startup.user == user
  end

  def update?
    edit?
  end

  def submit?
    edit?
  end

  def destroy?
    edit?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
