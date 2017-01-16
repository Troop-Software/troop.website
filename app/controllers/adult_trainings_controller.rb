class AdultTrainingsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_leader, only:  [:show, :index]
  before_action :require_user_leader_full, except:  [:show, :index]
  before_action :set_adult_training, only: [:edit, :update, :destroy]

  def index
    @adult_trainings = AdultTraining.all
  end

  def show
    @adult_trainings = AdultTraining.where(adult_id: params[:id])
    respond_to do |format|
      format.js {render layout: false} # Add this line to you respond_to block
    end
  end

  def new
    @adult_training = AdultTraining.new
  end

  def edit
  end

  def create
    @adult_training = AdultTraining.new(adult_training_params)

    respond_to do |format|
      if @adult_training.save
        format.html { redirect_to adult_path(@adult_training.adult_id), notice: 'Adult training was successfully created.' }
        format.json { render :show, status: :created, location: @adult_training }
      else
        format.html { render :new }
        format.json { render json: @adult_training.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @adult_training.update(adult_training_params)
        format.html { redirect_to adult_path(@adult_training.adult_id), notice: 'Adult training was successfully updated.' }
        format.json { render :show, status: :ok, location: @adult_training }
      else
        format.html { render :edit }
        format.json { render json: @adult_training.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @adult_training.destroy
    respond_to do |format|
      format.html { redirect_to adult_trainings_url, notice: 'Adult training was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_adult_training
    @adult_training = AdultTraining.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def adult_training_params
    params.require(:adult_training).permit(:adult_id, :adult_training_course_id, :completed_date)
  end
end
