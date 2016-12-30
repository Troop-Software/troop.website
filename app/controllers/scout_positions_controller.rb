class ScoutPositionsController < ApplicationController
  before_action :set_scout_position, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_user_leader, only: [:create, :edit, :update, :destroy]


  # GET /scout_positions
  # GET /scout_positions.json
  def index
    @scout_positions = ScoutPosition.all
  end

  # GET /scout_positions/1
  # GET /scout_positions/1.json
  def show
    @scout_positions_held = ScoutPosition.where(scout_id: params[:id])
    respond_to do |format|
      format.js {render layout: false} # Add this line to you respond_to block
    end
  end

  # GET /scout_positions/new
  def new
    @scout_position = ScoutPosition.new
  end

  # GET /scout_positions/1/edit
  def edit
  end

  # POST /scout_positions
  # POST /scout_positions.json
  def create
    @scout_position = ScoutPosition.new(scout_position_params)

    respond_to do |format|
      if @scout_position.save
        format.html { redirect_to @scout_position, notice: 'Scout position was successfully created.' }
        format.json { render :show, status: :created, location: @scout_position }
      else
        format.html { render :new }
        format.json { render json: @scout_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scout_positions/1
  # PATCH/PUT /scout_positions/1.json
  def update
    respond_to do |format|
      if @scout_position.update(scout_position_params)
        format.html { redirect_to @scout_position, notice: 'Scout position was successfully updated.' }
        format.json { render :show, status: :ok, location: @scout_position }
      else
        format.html { render :edit }
        format.json { render json: @scout_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scout_positions/1
  # DELETE /scout_positions/1.json
  def destroy
    @scout_position.destroy
    respond_to do |format|
      format.html { redirect_to scout_positions_url, notice: 'Scout position was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scout_position
      @scout_position = ScoutPosition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scout_position_params
      params.require(:scout_position).permit(:scout_id, :position_id, :start_date, :end_date)
    end
end
