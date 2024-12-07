class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :date, :time, :location, :user_id
end
