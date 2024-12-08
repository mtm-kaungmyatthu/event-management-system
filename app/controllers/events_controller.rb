# app/controllers/events_controller.rb
class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, except: [ :index, :new, :create, :registered_events ]
  before_action :authorize!, except: [:index, :registered_events]

  def index
    @events = EventPolicy::Scope.new(current_user, Event).list.page(params[:page]).per(Event::INDEX_LIMIT)
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
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity # Render edit page again with errors
    end
  end

  def register
    registration = @event.registrations.build(user: current_user)

    if registration.save!
      redirect_to registered_events_events_path, notice: "Event was successfully registered."
    else
      redirect_to @event, notice: "Event not was successfully registered."
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event was successfully deleted."
  end

  def registered_events
    @events = current_user.registered_events
  end

  def toggle_active
    @event.update(status: params[:status].present?)
    # Redirect back to the events page with a success message
    redirect_to events_path, notice: "Event status updated successfully."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :description, :date, :time, :location, :status)
    end

    def authorize!
      arg = @event.present? ? @event : Event
      authorize arg
    end
end
