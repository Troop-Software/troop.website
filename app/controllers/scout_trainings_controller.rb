class ScoutTrainingsController < ApplicationController
  before_action :set_scout_training, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_user_leader, only: [:create, :edit, :update, :destroy]

  # GET /scout_trainings
  # GET /scout_trainings.json
  def index
    @scout_trainings = ScoutTraining.all
  end

  # GET /scout_trainings/1
  # GET /scout_trainings/1.json
  def show
    @scout_trainings = ScoutTraining.where(scout_id: params[:id])
    respond_to do |format|
      format.js {render layout: false} # Add this line to you respond_to block
    end
  end

  # GET /scout_trainings/new
  def new
    @scout_training = ScoutTraining.new
  end

  # GET /scout_trainings/1/edit
  def edit
  end

  # POST /scout_trainings
  # POST /scout_trainings.json
  def create
    @scout_training = ScoutTraining.new(scout_training_params)

    respond_to do |format|
      if @scout_training.save
        format.html { redirect_to scout_path(@scout_training.scout), notice: 'Scout training was successfully created.' }
        format.json { render :show, status: :created, location: @scout_training }
      else
        format.html { render :new }
        format.json { render json: @scout_training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scout_trainings/1
  # PATCH/PUT /scout_trainings/1.json
  def update
    respond_to do |format|
      if @scout_training.update(scout_training_params)
        format.html { redirect_to scout_path(@scout_training.scout), notice: 'Scout training was successfully updated.' }
        format.json { render :show, status: :ok, location: @scout_training }
      else
        format.html { render :edit }
        format.json { render json: @scout_training.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scout_trainings/1
  # DELETE /scout_trainings/1.json
  def destroy
    @scout_training.destroy
    respond_to do |format|
      format.html { redirect_to scout_trainings_url, notice: 'Scout training was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scout_training
      @scout_training = ScoutTraining.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scout_training_params
      params.require(:scout_training).permit(:scout_id, :youth_training_id, :completed_date)
    end
end
