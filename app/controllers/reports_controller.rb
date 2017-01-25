class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_leader, except: :scout_detail_report

  def ypt_report
    @adults = Adult.where(inactive: false)
    respond_to do |format|
      format.pdf {
        send_data render_to_string,
                  filename: 'YPT Report.pdf',
                  type: 'application/pdf',
                  disposition: 'attachment'
      }
    end
  end

  def scout_detail_report
    if params[:id]
      @scout = Scout.find(params[:id])
    else
      @scouts = Scout.where(active: true)
      @scouts = Scout.all if current_user.show_inactive_scouts
    end

    respond_to do |format|
      format.pdf {
        send_data render_to_string,
                  filename: 'Scout Detailed Report.pdf',
                  type: 'application/pdf',
                  disposition: 'attachment'
      }
    end
  end

  def patrol_report
    @patrols= Patrol.all
    respond_to do |format|
      format.pdf {
        send_data render_to_string,
                  filename: 'Patrol Report.pdf',
                  type: 'application/pdf',
                  disposition: 'attachment'
      }
    end
  end

  def event_attendance_report
    current_event = params[:id]
    @event_details = Event.find(current_event)
    @adults_in_attendance = AdultEvent.where(event_id: current_event)
    @scouts_in_attendance = ScoutEvent.where(event_id: current_event)

    respond_to do |format|
      format.pdf {
        send_data render_to_string,
                  filename: 'Event Attendance Report.pdf',
                  type: 'application/pdf',
                  disposition: 'attachment'
      }
    end
  end

  def event_signup_sheet
    current_event = params[:id]
    @event_details = Event.find(current_event)
    @adults_in_attendance = AdultEvent.where(event_id: current_event)
    @scouts_in_attendance = ScoutEvent.where(event_id: current_event).order("updated_at asc")
    @url = root_url + 'events/' + current_event

    respond_to do |format|
      format.pdf {
        send_data render_to_string,
                  filename: 'Event Signup Sheet.pdf',
                  type: 'application/pdf',
                  disposition: 'attachment'
      }
    end
  end
end