class YouthAwardsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_leader_full, except: :show
  before_action :set_youth_award, only: [:show, :edit, :update, :destroy]

  def new
    @youth_award = YouthAward.new
  end

  def show
  end

  def index
    @youth_awards = YouthAward.search(params[:search])
  end

  def create
    @youth_award = YouthAward.new(youth_award_params)

    respond_to do |format|
      if @youth_award.save
        format.html { redirect_to youth_awards_path, notice: 'Award was successfully created.' }
        format.json { render :show, status: :created, location: @youth_award }
      else
        format.html { render :new }
        format.json { render json: @youth_award.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @youth_award.update(youth_award_params)
        format.html { redirect_to youth_awards_path, notice: 'Award was successfully updated.' }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @youth_award.destroy
    respond_to do |format|
      format.html {
        flash[:danger]= 'Award was successfully deleted.'
        redirect_to youth_awards_path
      }
      format.json { head :no_content }
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_youth_award
    @youth_award = YouthAward.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def youth_award_params
    params.require(:youth_award).permit(:name, :multiple, :active, :description )
  end
end