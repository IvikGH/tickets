class Ticket < ApplicationRecord

  belongs_to :status
  belongs_to :user
  belongs_to :department
end
