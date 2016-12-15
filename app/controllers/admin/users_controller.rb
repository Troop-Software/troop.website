class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update]

  # GET admin/users
  # GET admin/users.json
  def index
   # @users = User.paginate(page: params[:page], per_page: 20)
    @users = User.all
  end

  # GET admin/users/1
  # GET admin/users/1.json
  def show
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {
          flash[:success] = 'User was successfully updated.'
          redirect_to admin_user_path(@user)
        }
        format.json { render :show, status: :ok, location: admin_user_path(@user) }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :email, :password, role_ids: [])
  end
end
