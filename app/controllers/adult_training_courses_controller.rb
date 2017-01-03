class AdultTrainingCoursesController < ApplicationController
  before_action :set_atc, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!



  def index
    @atcs = AdultTrainingCourse.search(params[:id])
  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_atc
    @atc = AdultTrainingCourse.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def adult_params
    params.require(:adult_training_course).permit(:name, :bsa_code, :expired)
  end


end