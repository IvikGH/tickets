class Status < ApplicationRecord

  has_many :tickets

  CLOSED_STATUSES = %w[Cancelled Completed]
end
