class Comment < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :ticket

  validates :body, :ticket_id, presence: true

  validates :user_id, numericality: true,
            unless: Proc.new { |ticket| ticket.user_id.blank? }

  validates_format_of :body, with: /.+/, message: 'Message body shouldn`t be empty'
end
