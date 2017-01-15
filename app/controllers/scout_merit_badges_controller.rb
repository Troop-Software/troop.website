class ScoutMeritBadgesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_leader_full, except: [:show]
  before_action :set_scout_merit_badge, only: [:edit, :update]

  def index
    @scout_merit_badges = ScoutMeritBadge.search(params[:search]).where(current: true)
  end

  # GET /scout_rank_histories/new
  def new
    @scout_merit_badge = ScoutMeritBadge.new
  end

  def show
    @scout_merit_badge = ScoutMeritBadge.where(scout_id: params[:id])
    respond_to do |format|
      format.js {render layout: false} # Add this line to you respond_to block
    end
  end

  # POST /scout_rank_histories
  def create
    @scout_merit_badge = ScoutMeritBadge.new(scout_merit_badge_params)
    @scout_merit_badge.scout.recalc_rank_complete

    respond_to do |format|
      if @scout_merit_badge.save
        format.html {
          flash[:success] = 'Rank completion date saved.'
          if params[:create_and_add]
            redirect_to new_scout_merit_badge_path(scout_id: @scout_merit_badge.scout_id)
          else
            redirect_to scout_path(@scout_merit_badge.scout_id)
          end
        }
        format.json { render :show, status: :created, location: @scout_merit_badge }
      else
        format.html { render :new }
        format.json { render json: @scout_merit_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scout_rank_histories/1
  def update
    respond_to do |format|
      if @scout_merit_badge.update(scout_merit_badge_params)
        format.html {
          flash[:success] = 'Rank completion date updated.'
          redirect_to scout_path(@scout_merit_badge.scout_id)
        }
        format.json { render :show, status: :ok, location: @scout_merit_badge }
      else
        format.html { render :edit }
        format.json { render json: @scout_merit_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_scout_merit_badge
    @scout_merit_badge = ScoutMeritBadge.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def scout_merit_badge_params
    params.require(:scout_merit_badge).permit(:scout_id, :merit_badge_id, :completed)
  end

end