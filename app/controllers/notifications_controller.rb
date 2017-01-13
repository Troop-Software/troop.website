class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_user_leader

  def index
    @notifications = Notification.all
  end

  def edit
  end

  def new
    @notification = Notification.new
  end

  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html {
          flash[:success] = 'Notification was successfully updated.'
          redirect_to notifications_path
        }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end
  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html {
          flash[:success] = 'Notice was successfully created.'
          redirect_to notifications_path
        }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html {
        flash[:danger] = 'Notice was successfully destroyed.'
        redirect_to notifications_url
      }
      format.json { head :no_content }
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_notification
    @notification = Notification.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def notification_params
    params.require(:notification).permit(:text,:link,:active,:display_until)
  end

end
