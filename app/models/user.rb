class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tickets
  has_many :comments

  validates_presence_of :first_name, :last_name, :email

  validates :email, format: { with: Devise.email_regexp,
                              message: 'Wrong email format' }

  def name
    "#{first_name} #{last_name}"
  end
end
