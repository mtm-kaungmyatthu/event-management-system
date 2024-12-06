class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events
  has_many :registrations
  has_many :registered_events, through: :registrations, source: :event
  enum :role, { member: 1, admin: 2 }
end
