require 'rails_helper'

RSpec.feature "Tickets index page", type: :feature, js: true do

  scenario "All statuses are shown on 'Open' tab except 'Cancelled' 'Complete'" do
    generate_standart_statuses
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit tickets_path

    expect(page).not_to have_content 'Cancelled'
    expect(page).not_to have_content 'Completed'
  end

  fscenario "'Cancelled' 'Completed' statuses are shown on 'Closed' tab" do
    generate_standart_statuses

    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit tickets_path
    click_on 'Closed'

    expect(page).to have_content 'Cancelled'
    expect(page).to have_content 'Completed'
  end

  scenario "new tickets are shown on 'Open' tab" do
    generate_standart_statuses
    FactoryGirl.create(:department)
    ticket = FactoryGirl.create(:ticket)

    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit tickets_path

    expect(page).to have_content ticket.uniq_reference
    expect(page).to have_content ticket.subject
  end

  scenario "'Cancelled' and 'Completed' ticket are not shown on 'Open' tab" do
    generate_standart_statuses
    status_cancelled = Status.find_by_title('Cancelled')
    status_completed = Status.find_by_title('Completed')
    FactoryGirl.create(:department)
    ticket_completed = FactoryGirl.create(:ticket,status_id: status_completed.id )
    ticket_cancelled = FactoryGirl.create(:ticket, status_id: status_cancelled.id )

    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit tickets_path

    expect(page).not_to have_content ticket_completed.uniq_reference
    expect(page).not_to have_content ticket_cancelled.uniq_reference
  end
end
