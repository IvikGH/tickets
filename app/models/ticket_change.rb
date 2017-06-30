class TicketChange < ApplicationRecord

  belongs_to :ticket

  validates_presence_of :ticket_id, :attribute_class,
                        :prev_value, :current_value
end
