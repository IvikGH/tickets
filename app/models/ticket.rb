class Ticket < ApplicationRecord

  belongs_to :status
  belongs_to :user, optional: true
  belongs_to :department
  has_many   :comments, dependent: :destroy

  validates_presence_of :status_id, :department_id, :subject, :description,
                        :employee, :employee_email, :uniq_reference

  validates :department_id, :status_id, numericality: true

  validates :user_id, numericality: true,
            unless: Proc.new { |ticket| ticket.user_id.blank? }

  validates :employee_email,
            format: { with: Devise.email_regexp,
                      message: 'Wrong email format' }

  validates :employee,
            format: { with: /[A-ZА-Я]\w+\s[A-ZА-Я]\w+/,
                      message: 'Wrong Name format: Bond James' }

  validates :uniq_reference, length: { maximum: 17 }
  validates :uniq_reference, format: { with: /[A-Z0-9-]{17}/ }

end
