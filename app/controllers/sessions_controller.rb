class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    if json_request?
      json_signin
    else
      super
    end
  end

  private

  def json_request?
    request.format.json?
  end

  def json_signin
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    respond_with resource,
      location: after_sign_in_path_for(resource),
      serializer: UserSessionsSerializer
  end
end
