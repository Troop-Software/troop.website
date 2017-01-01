class AdultPositionsController < ApplicationController
  before_action :set_adult_position, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_user_leader_full

  def edit
  end

  def new
    @adult_position = AdultPosition.new
  end

  def index
    @adult_positions = AdultPosition.search(params[:search])
  end

  def update
    respond_to do |format|
      if @adult_position.update(adult_position_params)
        format.html {
          flash[:success] = 'Position was successfully updated.'
          redirect_to adult_positions_path
        }
        format.json { render :show, status: :ok, location: @adult_position }
      else
        format.html { render :edit }
        format.json { render json: @adult_position.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @adult_position = AdultPosition.new(adult_position_params)

    respond_to do |format|
      if @adult_position.save
        format.html {
          flash[:success] = 'Position was successfully created.'
          redirect_to adult_positions_path
        }
        format.json { render :show, status: :created, location: @position }
      else
        format.html { render :new }
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
    params.require(:adult_position).permit(:name, :abbr)
  end
end