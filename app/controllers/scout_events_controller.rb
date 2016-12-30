class ScoutEventsController < ApplicationController
  include ApplicationHelper

  before_action :set_scout_event, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_user_leader, only: [:create, :edit, :update, :destroy]

  helper_method :get_scout_activities

  # GET /scout_events
  # GET /scout_events.json
  def index
    # only show events +- 30 days
    #@scout_events = ScoutEvent.events_in_60_day_window
    @scout_events = ScoutEvent.events_in_year_window
  end

  # GET /scout_events/1
  # GET /scout_events/1.json
  def show
    @scout_activities = ScoutEvent.where(scout_id: params[:id]).joins(:event).order('events.start DESC')
    respond_to do |format|
      format.js {render layout: false} # Add this line to you respond_to block
    end
  end

  # GET /scout_events/new
  def new
    @scout_event = ScoutEvent.new
  end

  # GET /scout_events/1/edit
  def edit
  end

  # POST /scout_events
  # POST /scout_events.json
  def create
    @scout_event = ScoutEvent.new(scout_event_params)

    respond_to do |format|
      if @scout_event.save
        format.html { redirect_to scout_events_path, notice: 'Scout event was successfully created.' }
        format.json { render :show, status: :created, location: @scout_event }
      else
        format.html { render :new }
        format.json { render json: @scout_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scout_events/1
  # PATCH/PUT /scout_events/1.json
  def update
    respond_to do |format|
      if @scout_event.update(scout_event_params)
        format.html { redirect_to scout_events_path, notice: 'Scout event was successfully updated.' }
        format.json { render :show, status: :ok, location: @scout_event }
      else
        format.html { render :edit }
        format.json { render json: @scout_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scout_events/1
  # DELETE /scout_events/1.json
  def destroy
    @scout_event.destroy
    respond_to do |format|
      format.html { redirect_to scout_events_url, notice: 'Scout event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scout_event
      @scout_event = ScoutEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scout_event_params
      params.require(:scout_event).permit(:scout_id, :event_id, :notes)
    end


end
