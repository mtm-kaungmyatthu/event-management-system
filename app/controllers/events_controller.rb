# app/controllers/events_controller.rb
class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, except: [ :index, :new, :registered_events ]

  def index
    @events = EventPolicy::Scope.new(current_user, Event, params[:page]).list
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # POST /events
  def create
    @event = current_user.events.new(event_params)
    if @event.save
      redirect_to @event, notice: "Event was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /events/:id
  def update
    if @event.update(event_params.merge(user_id: current_user.id))
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity # Render edit page again with errors
    end
  end

  def register
    registration = @event.registrations.build(user: current_user)

    if registration.save!
      redirect_to registered_events_events_path, notice: "Event was successfully created."
    else
      redirect_to @event, notice: "Event not was successfully created."
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event was successfully deleted."
  end

  def registered_events
    @events = current_user.registered_events
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :description, :date, :time, :location)
    end
end
