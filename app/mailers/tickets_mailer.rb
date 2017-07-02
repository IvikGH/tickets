class TicketsMailer < ApplicationMailer

  def creation_inform(ticket)
    @ticket = ticket

    mail(to: ticket.employee_email, subject: "Ticket '#{ticket.subject}' was created")
  end
end
