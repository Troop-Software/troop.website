class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username] )
    devise_parameter_sanitizer.permit(:account_update, keys: [:show_inactive_scouts] )
  end

  def convert_date(date) #convert bootstrap date to rails date
    date_format = '%m/%d/%Y'
    offset = DateTime.now.strftime('%z')
    date = date != '' ? DateTime.strptime(date, date_format).change(:offset => offset).to_s : date
  end

  def convert_datetime(datetime) #convert bootstrap datetime to rails datetime
    date_format = '%m/%d/%Y %I:%M %p'
    offset = DateTime.now.strftime('%z')
    date = date != '' ? DateTime.strptime(date, date_format).change(:offset => offset).to_s : date
  end

  def deny_access
    flash[:danger] = 'Sorry you do not have permissions'
    redirect_to :back
  end

  def require_user_leader
    deny_access if !current_user.role? :leader
  end

  def require_user_leader_full
    deny_access if !current_user.role? :leader_full
  end

  def require_admin_user
    deny_access if !current_user.role? :admin
  end
end
