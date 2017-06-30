require 'rails_helper'

RSpec.feature "Log in page", type: :feature do
  feature 'Sign In page' do

    scenario "has new ticket form" do

      visit root_path

      expect(page).to have_content "Create ticket or Log in"
      within ".row > .col-8" do
        expect(page).to have_content "Department:"
        expect(page).to have_content "Full name (last first)"
        expect(page).to have_content "Subject:"
        expect(page).to have_content "Email:"
        expect(page).to have_content "Description:"
        value = 'Report ticket'
        expect(find_button(value).value).to eq value
      end
    end
  end
end
