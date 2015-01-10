require "rails_helper"

feature "Root Page" do
  scenario "visiting the root page" do
    pending "Completion of React code"
    visit "/"

    expect(page).to have_content "json-api.rocks"

    expect(page).to have_content "JSON Endpoints"
    expect(page).to have_content "GET /api/movies"
    expect(page).to have_content "POST /api/movies"
  end
end
