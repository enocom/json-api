require "rails_helper"

RSpec.describe "Root Page", type: :feature do
  specify "visiting the root page" do
    visit "/"

    expect(page).to have_content "json-api.rocks"
    expect(page).to have_content "JSON Endpoints"
    expect(page).to have_content "GET /api/movies"
    expect(page).to have_content "POST /api/movies"
  end
end
