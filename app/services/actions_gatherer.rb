class ActionsGatherer
  def self.call(ticket_id)
    actions = TicketChange.where(ticket_id: ticket_id).to_a +
              Comment.where(ticket_id: ticket_id).to_a

    actions.sort! { |a,b| a.created_at <=> b.created_at }
  end
end
