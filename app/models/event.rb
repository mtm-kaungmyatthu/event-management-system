class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations
  has_many :registered_users, through: :registrations, source: :user
end
