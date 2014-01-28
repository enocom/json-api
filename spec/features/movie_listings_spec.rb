require "spec_helper"

feature "movie listings", :js do
  before do
    FactoryGirl.create :movie, title: "Lost in Translation",
      director: "Sophia Coppola"
    FactoryGirl.create :movie, title: "Akira",
      director: "Katsuhira Otomo"
  end

  scenario "viewing movies" do
    visit "/#/movies"

    expect(page).to have_content "Lost in Translation"
    expect(page).to have_content "Akira"

    click_on "Lost in Translation"

    expect(page).to have_content "Sophia Coppola"
  end
end
