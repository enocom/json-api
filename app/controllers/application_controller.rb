class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authenticate_user_from_token!
    api_token = request.headers["X-API-KEY"].presence
    user      = api_token && User.find_by(authentication_token: api_token)

    if user
      sign_in user, store: false
    end
  end
end
