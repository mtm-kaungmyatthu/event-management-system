class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def dash_board
    @events = Event.all
  end
end
