class YouthAwardRequirementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_youth_award_requirement, only: [:show, :edit, :update, :destroy]
  before_action :require_user_leader, only: [:create, :edit, :update, :destroy]

  def new
    @youth_award_requirement = YouthAwardRequirement.new
  end

  def show
  end

  def edit
  end

  def index
    @youth_award_requirements = YouthAwardRequirement.all
  end

  def create
    @youth_award_requirement = YouthAwardRequirement.new(youth_award_requirement_params)

    respond_to do |format|
      if @youth_award_requirement.save
        format.html { redirect_to youth_award_path(@youth_award_requirement.youth_award_id), notice: 'Award Requirement was successfully created.' }
        format.json { render :show, status: :created, location: @youth_award_requirement }
      else
        format.html { render :new }
        format.json { render json: @youth_award_requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @youth_award_requirement.update(youth_award_requirement_params)
        format.html { redirect_to youth_award_path(@youth_award_requirement.youth_award_id), notice: 'Award Requirement was successfully updated.' }
        format.json { render :show, status: :ok, location: @youth_award_requirement }
      else
        format.html { render :edit }
        format.json { render json: @youth_award_requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @youth_award_requirement.destroy
    respond_to do |format|
      format.html {
        flash[:danger]= 'Award Requirement was successfully deleted.'
        redirect_to youth_award_requirements_path
      }
      format.json { head :no_content }
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_youth_award_requirement
    @youth_award_requirement = YouthAwardRequirement.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def youth_award_requirement_params
    params.require(:youth_award_requirement).permit(:youth_award_id, :req_num, :description )
  end
end