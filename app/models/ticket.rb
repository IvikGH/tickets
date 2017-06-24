class Ticket < ApplicationRecord

  belongs_to :status
  belongs_to :user, optional: true
  belongs_to :department

end
