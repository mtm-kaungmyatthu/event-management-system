class ApplicationController < ActionController::Base
  include Pundit::Authorization
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  rescue_from JWT::DecodeError, with: :unauthorized_error
  protect_from_forgery with: :null_session

  private

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decoded = JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded
    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end

  def unauthorized_error
    render json: { error: "Invalid token" }, status: :unauthorized
  end
end
