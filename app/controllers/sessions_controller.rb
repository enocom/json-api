class SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    json_request? ? json_signin : super
  end

  private

  def json_request?
    request.format.json?
  end

  def json_signin
    # this code is simply a variation of Devise::SessionsController#create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    respond_with resource,
      location: after_sign_in_path_for(resource),
      serializer: UserSessionsSerializer
  end
end
