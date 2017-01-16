class AdultPositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_leader_full
  before_action :set_adult_position, only: [:edit, :update, :destroy]


  def new
    @adult_position = AdultPosition.new
  end

  def edit
  end

  def create
    @adult_position = AdultPosition.new(adult_position_params)

    respond_to do |format|
      if @adult_position.save
        format.html { redirect_to adult_path(@adult_position.adult_id), notice: 'Adult position was successfully created.' }
        format.json { render :show, status: :created, location: @adult_position }
      else
        format.html { render :new }
        format.json { render json: @adult_position.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @adult_position.update(adult_position_params)
        format.html { redirect_to adult_path(@adult_position.adult_id), notice: 'Adult position was successfully updated.' }
        format.json { render :show, status: :ok, location: @adult_position }
      else
        format.html { render :edit }
        format.json { render json: @adult_position.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_adult_position
    @adult_position = AdultPosition.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def adult_position_params
    params.require(:adult_position).permit(:adult_id, :position_id, :start_date, :end_date)
  end
end