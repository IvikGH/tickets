require 'rails_helper'

RSpec.feature "Ticket show page", type: :feature, js: true do

  scenario "click on ticket reference number will load ticket page" do
    generate_standart_statuses
    FactoryGirl.create(:department)
    ticket = FactoryGirl.create(:ticket)

    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit tickets_path

    click_on(ticket.uniq_reference)

    expect(page).to have_content 'Waiting for Staff Response'
    expect(page).to have_content 'Owned by'
    expect(page).to have_content "Reported by: #{ticket.employee} (#{ticket.employee_email})"
    expect(page).to have_content "Subject: #{ticket.subject}"
    expect(page).to have_content ticket.description
    expect(page).to have_content 'Comments and changes:'
  end

  scenario "Changing status will show new status on page" do
    generate_standart_statuses
    FactoryGirl.create(:department)
    ticket = FactoryGirl.create(:ticket)

    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit ticket_path(ticket)
    status = Status.last

    find('#ticket_status_id').select(status.title)
    click_on 'Change status'

    expect(first('.card > .card-block > .badge-default').text).to eq status.title
  end

  scenario "Changing status will add log about it" do
    generate_standart_statuses
    FactoryGirl.create(:department)
    ticket = FactoryGirl.create(:ticket)

    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit ticket_path(ticket)
    status = Status.last

    find('#ticket_status_id').select(status.title)
    click_on 'Change status'
    object = TicketChange.where(ticket_id: ticket).last
    time = object.created_at.strftime("at %H:%M %d-%m-%Y")

    expect(page).to have_content "#{time}: #{object.attribute_class.downcase} was changed: from '#{object.prev_value}' to '#{object.current_value}'"
  end
end
