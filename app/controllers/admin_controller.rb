class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  private
  def require_admin
    unless current_user.role? :admin
      flash[:danger] = 'You must be an admin to access this section'
      redirect_to root_path
    end
  end
end
