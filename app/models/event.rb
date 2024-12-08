class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations, dependent: :destroy
  has_many :registered_users, through: :registrations, source: :user

  validates :name, :location, presence: true
  validates :description, length: { maximum: 1000 }
  validates :location, length: { maximum: 255 }
  validate :event_date_cannot_be_in_the_past

  private

  def event_date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if date.present? && date < Date.today
    errors.add(:time, "can't be in the past") if time.present? && time < Time.now
  end
end
