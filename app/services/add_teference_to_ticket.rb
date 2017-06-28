class AddTeferenceToTicket

  class << self
    def add_ref(ticket)
      is_uniq = false

      until is_uniq
        uniq_reference = ReferenceGenerator.generate_reference
        is_uniq = !Ticket.exists?(uniq_reference: uniq_reference)
      end

      ticket.uniq_reference = uniq_reference
    end
  end
end
