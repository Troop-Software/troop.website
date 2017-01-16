class ScoutAwardsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_leader_full, except: :show
  before_action :set_scout_award, only: [ :edit, :update, :destroy]

  def new
    @scout_award = ScoutAward.new
  end

  def edit
  end

  def show
    @scout_awards = ScoutAward.where(scout_id: params[:id])
    respond_to do |format|
      format.js {render layout: false} # Add this line to you respond_to block
    end
  end

  def index
    @scout_awards = ScoutAward.all
  end

  def create
    @scout_award = ScoutAward.new(scout_award_params)

    respond_to do |format|
      if @scout_award.save
        format.html { redirect_to scout_path(@scout_award.scout), notice: 'Scout Award was successfully created.' }
        format.json { render :show, status: :created, location: @scout_award }
      else
        format.html { render :new }
        format.json { render json: @scout_award.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    respond_to do |format|
      if @scout_award.update(scout_event_params)
        format.html { redirect_to scout_path(@scout_award.scout), notice: 'Scout Award was successfully updated.' }
        format.json { render :show, status: :ok, location: @scout_award }
      else
        format.html { render :edit }
        format.json { render json: @scout_award.errors, status: :unprocessable_entity }
      end
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_scout_award
    @scout_award = ScoutAward.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def scout_award_params
    params.require(:scout_award).permit(:scout_id, :youth_award_id, :completed_date)
  end
end
