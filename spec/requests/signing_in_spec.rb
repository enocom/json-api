require "spec_helper"

describe "Signing in to use the API" do
  it "requires a user to sign in" do
    payload = {}
    headers = { "Accept" => "application/json" }

    get "/movies", payload, headers

    expect(response.status).to be 401
  end

  it "allows a user to sign in and returns a token" do
    u = User.create email: "doe@example.com", password: "password"
    payload = { user: { email: u.email, password: u.password } }.to_json
    headers = { "Accept" => "application/json",
                "Content-Type" => "application/json" }

    post "/users/sign_in", payload, headers

    expect(response.status).to be 201

    body = JSON.parse(response.body)
    expect(body["authentication_token"]).to be
  end
end
