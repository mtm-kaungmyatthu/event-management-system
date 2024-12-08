class UsersController < ApplicationController
  def index
    authorize current_user
    @users = User.all
  end

  def dash_board
    @events = EventPolicy::Scope.new(current_user, Event, params[:page]).list.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create_new_user
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created successfully."
      redirect_to users_path
    else
      flash.now[:error] = "Error creating user."
      render :new
    end
  end

  def show
    @user = User.find(params[:id]) # Find the event by ID and display it
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle_active
    @user = User.find(params[:id])
    @user.update(status: params[:status].present?)
    # Redirect back to the events page with a success message
    redirect_to users_path, notice: "User status updated successfully."
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "User was successfully deleted."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end
end
