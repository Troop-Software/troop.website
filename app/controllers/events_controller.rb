class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :require_user_leader_full, except: [:show, :index]
  before_action :set_event, only: [:show, :edit, :update, :destroy]


  # GET /events
  # GET /events.json
  def index
    @events = Event.search(params[:search])
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to events_path, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def calendar_export
    @events = Event.all
    respond_to do |format|
      format.ics do
        cal = Icalendar::Calendar.new
        @events.each do |event|
          ics_event = Icalendar::Event.new
          ics_event.dtstart = event.start
          ics_event.dtend = event.end unless event.end.nil?
          ics_event.summary = event.title
          ics_event.description = event.description
          ics_event.url = event.external_link
          cal.add_event(ics_event)
        end
        cal.publish
        render text: cal.to_ical
      end
      format.csv { send_data Event.all.to_csv('troopCalendar'), filename: 'troopCalendar.csv' }
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :description, :start, :end, :allDay, :category, :logged_units,
                                  :external_link, :location_id, :last_registration_date, :cost  )
  end
end
