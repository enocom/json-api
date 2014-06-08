require "rails_helper"

describe User do
  it "saves an authentication token" do
    u = User.new email: "foo@bar.com", password: "password"
    u.save

    expect(u.authentication_token).to be
  end
end
