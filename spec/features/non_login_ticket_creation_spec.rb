require 'rails_helper'

RSpec.feature "Log in page", type: :feature do
  scenario "Ticket can be created without login" do
    generate_standart_statuses
    FactoryGirl.create(:department)

    visit new_user_session_path

    expect {
      within ".row > .col-8" do
        find('#ticket_department_id').select(find('#ticket_department_id :last-child').text)
        fill_in "ticket[employee]", with: "Agar Io"
        fill_in "ticket[employee_email]", with: "aaa@bbb.ccc"
        fill_in "ticket[subject]", with: "Some subject"
        fill_in "ticket[description]", with: "Trying out Capybara"
        click_button "Report ticket"
      end
    }.to change(Ticket, :count).by(1)
  end
end
