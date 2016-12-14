class ScoutRankHistoriesController < ApplicationController
  before_action :set_srh_requirement, only: [:show, :edit, :update]
  before_action :authenticate_user!
  before_action :require_admin_user, only: [:destroy, :index]

  def index
    @scout_rank_histories = ScoutRankHistory.all
  end

  # GET /scout_rank_histories/new
  def new
    @scout_rank_history = ScoutRankHistory.new
  end

  def show
  end

  # POST /scout_rank_histories
  def create
    @scout_rank_history = ScoutRankHistory.new(srh_requirement_params)

    respond_to do |format|
      if @scout_rank_history.save
        format.html {
          flash[:success] = 'Rank completion date saved.'
          redirect_to :back
        }
        format.json { render :show, status: :created, location: @scout_rank_history }
      else
        format.html { render :new }
        format.json { render json: @scout_rank_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scout_rank_histories/1
  def update
    respond_to do |format|
      if @scout_rank_history.update(srh_requirement_params)
        format.html {
          flash[:success] = 'Rank completion date updated.'
          redirect_to scout_path(@scout_rank_history.scout_id)
        }
        format.json { render :show, status: :ok, location: @scout_rank_history }
      else
        format.html { render :edit }
        format.json { render json: @scout_rank_history.errors, status: :unprocessable_entity }
      end
    end
  end

  private

# Use callbacks to share common setup or constraints between actions.
  def set_srh_requirement
    @scout_rank_history = ScoutRankHistory.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def srh_requirement_params
    params.require(:scout_rank_history).permit(:scout_id, :rank_id, :rank_completed)
  end

  def require_admin_user
    if !current_user.role? :admin
      flash[:danger] = 'Sorry you do not have permissions to modify scout_requirements'
      redirect_to category_path
    end
  end

end