class TicketChangesWriter

  class << self
    def write_changes(ticket)
      status_ids = ticket.previous_changes['status_id']
      user_ids = ticket.previous_changes['user_id']
      return unless status_ids || user_ids

      create_changes(ticket, Status.where(id: status_ids)) if status_ids
      create_changes(ticket, User.where(id: user_ids)) if user_ids
    end

    private

    def create_changes(ticket, instances)
      class_name = instances[0].class.name
      attribute_name = class_name == 'Status' ? :title : :name
      TicketChange.create(ticket_id: ticket.id,
                          attribute_class: class_name,
                          prev_value: instances.first.public_send(attribute_name),
                          current_value: instances.last.public_send(attribute_name))
    end
  end

end
