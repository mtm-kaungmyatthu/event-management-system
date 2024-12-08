class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations, dependent: :destroy
  has_many :registered_users, through: :registrations, source: :user

  attribute :status, default: :true
  validates :name, :location, :date, :time, presence: true
  validates :description, length: { maximum: 1000 }
  validates :location, length: { maximum: 255 }
  validate :event_date_cannot_be_in_the_past

  DASHBOARD_LIMIT = 12
  INDEX_LIMIT = 10

  private

  def event_date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if date.present? && date < Date.today
    errors.add(:time, "can't be in the past") if date.present? && time.present? && date <= Date.today && time < Time.now
  end
end
