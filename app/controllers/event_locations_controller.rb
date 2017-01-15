class EventLocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event_location, only: [:show, :edit, :update, :destroy]

  # GET /event_locations
  # GET /event_locations.json
  def index
    @event_locations = EventLocation.all
  end

  # GET /event_locations/1
  # GET /event_locations/1.json
  def show
    @events = Event.where(location_id: @event_location).order(:start).last(20)
  end

  # GET /event_locations/new
  def new
    @event_location = EventLocation.new
  end

  # GET /event_locations/1/edit
  def edit
  end

  # POST /event_locations
  # POST /event_locations.json
  def create
    @event_location = EventLocation.new(event_location_params)

    respond_to do |format|
      if @event_location.save
        format.html { redirect_to @event_location, notice: 'Event location was successfully created.' }
        format.json { render :show, status: :created, location: @event_location }
      else
        format.html { render :new }
        format.json { render json: @event_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_locations/1
  # PATCH/PUT /event_locations/1.json
  def update
    respond_to do |format|
      if @event_location.update(event_location_params)
        format.html { redirect_to @event_location, notice: 'Event location was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_location }
      else
        format.html { render :edit }
        format.json { render json: @event_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_locations/1
  # DELETE /event_locations/1.json
  def destroy
    @event_location.destroy
    respond_to do |format|
      format.html { redirect_to event_locations_url, notice: 'Event location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_location
      @event_location = EventLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_location_params
      params.require(:event_location).permit(:name, :street, :city, :state, :zip, :type)
    end
end
