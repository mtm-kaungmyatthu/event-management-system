# app/controllers/events_controller.rb
class EventsController < ApplicationController
  # before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  def index
    @events = Event.all
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # POST /events
  def create
    @event = Event.new(event_params.merge(user_id: current_user.id))
    if @event.save
      redirect_to @event, notice: "Event was successfully created."
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id]) # Find the event by ID and display it
  end

  def edit
    @event = Event.find(params[:id]) # Find the event by ID and display it
  end

  # PATCH/PUT /events/:id
  def update
    set_event
    if @event.update(event_params.merge(user_id: current_user.id))
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity # Render edit page again with errors
    end
  end

  def destroy
    set_event
    @event.destroy
    redirect_to events_path, notice: "Event was successfully deleted."
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
