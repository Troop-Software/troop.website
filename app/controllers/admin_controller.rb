class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def home
    @admin = User.paginate(page: params[:page], per_page: 20)
  end

  private
  def require_admin
    unless current_user.try(:admin?)
      flash[:danger] = 'You must be an admin to access this section'
      redirect_to root_path
    end
  end
end
