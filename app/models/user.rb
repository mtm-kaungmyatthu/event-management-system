class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events, dependent: :destroy
  has_many :registrations
  has_many :registered_events, through: :registrations, source: :event
  enum :role, { member: 1, admin: 2 }

  validates :name, :email, presence: true
  validates :password, presence: true, unless: :persisted?
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  INDEX_LIMIT = 10
end
