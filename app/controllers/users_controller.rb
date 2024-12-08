class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize!
  before_action :set_user, except: [ :index, :dash_board, :new, :create_new_user ]

  def index
    @users = User.all.page(params[:page]).per(User::INDEX_LIMIT)
  end

  def dash_board
    @events = EventPolicy::Scope.new(current_user, Event).list.page(params[:page]).per(Event::DASHBOARD_LIMIT)
  end

  def new
    @user = User.new
  end

  def create_new_user
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User created successfully."
      redirect_to users_path
    else
      flash.now[:error] = "Error creating user."
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle_active
    @user.update(status: params[:status].present?)
    # Redirect back to the events page with a success message
    redirect_to users_path, notice: "User status updated successfully."
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User was successfully deleted."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end

  def authorize!
    authorize current_user
  end

  def set_user
    @user = User.find(params[:id])
  end
end
