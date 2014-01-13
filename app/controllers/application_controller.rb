class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authenticate_user_from_token!
    # This code is taken from Jose Valim's gist:
    # https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
    user_email = params[:user_email].presence
    user       = user_email && User.find_by(email: user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      sign_in user, store: false
    end
  end
end
