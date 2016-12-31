class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_leader

  def scout_detail_report
    if params[:id]
      @scout = Scout.find(params[:id])
    else
      @scouts = Scout.where(active: true)
      @scouts = Scout.all if current_user.show_inactive_scouts
    end

    respond_to do |format|
      format.pdf {
        send_data render_to_string, filename: 'Scout Detailed Report.pdf', type: 'application/pdf', disposition: 'attachment'
      }
    end
  end

end