class Api::V1::EventsController < ApplicationController
  before_action :authorize_request

  def create
    @event = @current_user.events.new(event_params)
    if @event.save
      render json: { message: "Event created successfully", event: @event }, status: :created
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :date, :time, :location)
  end
end
