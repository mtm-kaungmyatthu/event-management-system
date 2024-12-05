class Api::V1::AuthController < ApplicationController
  # POST /api/v1/login
  def login
    @user = User.find_by(email: params[:email])
    if @user&.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { token: token, user: @user }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
