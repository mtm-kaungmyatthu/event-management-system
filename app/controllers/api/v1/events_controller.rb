class Api::V1::EventsController < ApplicationController
  before_action :authorize_request

  def index
    @events = EventPolicy::Scope.new(current_user, Event, params[:page]).list
    render json: @events, each_serializer: EventSerializer, status: :ok
  end

  def create
    @event = @current_user.events.new(event_params)
    if @event.save
      render json: {
        message: "Event created successfully",
        event: EventSerializer.new(@event).as_json
      }, status: :ok
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def register
    event = Event.find(params[:id])

    registration = event.registrations.build(user: @current_user)

    if registration.save!
        render json: {
        message: "Successfully registered for the event",
        event: EventSerializer.new(event).as_json
      }, status: :ok
    else
      render json: { errors: registration.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :date, :time, :location)
  end
end
