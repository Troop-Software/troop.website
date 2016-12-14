class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:acount_update, keys: [:username])
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

  def require_admin_user
    if !current_user.role? :admin
      flash[:danger] = 'Sorry you do not have permissions to modify categories'
      redirect_to category_path
    end
  end
end
