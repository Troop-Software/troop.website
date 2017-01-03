class AdultVehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_leader, only: :create

  def new
    @adult_vehicle = AdultVehicle.new
  end

  def create
    @adult_vehicle = AdultVehicle.new(adult_vehicle_params)

    respond_to do |format|
      if @adult_vehicle.save
        format.html { redirect_to adult_path(@adult_vehicle.adult_id), notice: 'Adult vehicle was successfully created.' }
        format.json { render :show, status: :created, location: @adult_vehicle }
      else
        format.html { redirect_to new_adult_vehicle_path(adult_id: @adult_vehicle.adult.id, message: ' ')}
        format.json { render json: @adult_vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def adult_vehicle_params
    params.require(:adult_vehicle).permit(:adult_id, :vehicle_id)
  end
end
