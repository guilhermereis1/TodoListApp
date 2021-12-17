class EventsController < ApplicationController
  before_action :set_event, only: %i[ show destroy ]
  before_action :authenticate_user!

  # GET /events or /events.json
  def index
    @events = Event.where(user_id: current_user.id)
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end
end
