class AdultEventsController < ApplicationController
  include ApplicationHelper

  before_action :set_adult_event, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_user_leader, only: [:create, :edit, :update, :destroy]

  def new
    @adult_event = AdultEvent.new
  end

  def index
    @adult_events = AdultEvent.events_in_year_window
  end

  def create
    @adult_event = AdultEvent.new(adult_event_params)

    respond_to do |format|
      if @adult_event.save
        format.html { redirect_to adult_path(@adult_event.adult), notice: 'Scout event was successfully created.' }
        format.json { render :show, status: :created, location: @adult_event }
      else
        format.html { render :back }
        format.json { render json: @adult_event.errors, status: :unprocessable_entity }
      end
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_adult_event
    @adult_event = AdultEvent.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def adult_event_params
    params.require(:adult_event).permit(:adult_id, :event_id, :notes)
  end

end
