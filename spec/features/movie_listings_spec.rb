require "spec_helper"

feature "movie listings", :js do
  scenario "viewing all the movies" do
    FactoryGirl.create :movie, title: "Lost in Translation"
    FactoryGirl.create :movie, title: "Akira"

    visit "/"

    expect(page).to have_content "Lost in Translation"
    expect(page).to have_content "Akira"
  end
end
