class ScoutRequirementsController < ApplicationController
   before_action :set_scout_requirement, only: [:show, :edit, :update, :destroy]
   before_action :authenticate_user!
   before_action :require_admin_user, only: [:create, :edit, :update, :destroy]
  #
  # # GET /categories
  # # GET /categories.json
   def index
     @scout_requirements = ScoutRequirement.all
   end
  #
  # # GET /categories/1
  # # GET /categories/1.json
   def show
  #   @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
   end
  #
  # # GET /categories/new
   def new
    @scout_requirement = ScoutRequirement.new
   end
  #
  # # GET /categories/1/edit
   def edit

   end
  #
  # # POST /categories
  # # POST /categories.json
   def create
    @scout_requirement = ScoutRequirement.new(scout_requirement_params)

    respond_to do |format|
      if @scout_requirement.save
        format.html {
          flash[:success] = "Scout's Requirement was successfully was successfully created."
          redirect_to :back
        }
        format.json { render :show, status: :created, location: @scout_requirement }
      else
        format.html { render :new }
        format.json { render json: @scout_requirement.errors, status: :unprocessable_entity }
      end
    end
  end
  #
  # # PATCH/PUT /categories/1
  # # PATCH/PUT /categories/1.json
   def update
    respond_to do |format|
      if @scout_requirement.update(scout_requirement_params)
        format.html {
          flash[:success] = "Scout's Requirement was successfully updated."
          redirect_to :back
        }
        format.json { render :show, status: :ok, location: @scout_requirement }
      else
        format.html { render :edit }
        format.json { render json: @scout_requirement.errors, status: :unprocessable_entity }
      end
    end
   end
  #
  # # DELETE /categories/1
  # # DELETE /categories/1.json
   def destroy
    @scout_requirement.destroy
    respond_to do |format|
      format.html {
        flash[:danger] = 'Sign off for this requirement was successfully removed.'
        redirect_to scout_requirements_path
      }
      format.json { head :no_content }
    end
   end

   private
  # # Use callbacks to share common setup or constraints between actions.
   def set_scout_requirement
     @scout_requirement = ScoutRequirement.find(params[:id])
   end
  #
  # # Never trust parameters from the scary internet, only allow the white list through.
   def scout_requirement_params
     params.require(:scout_requirement).permit(:scout_id, :requirement_id, :sign_off, :completed_date)
                                              # requirements_attributes: [:description])
   end
  #
   def require_admin_user
     if !current_user.admin?
       flash[:danger] = 'Sorry you do not have permissions to modify categories'
       redirect_to category_path
     end
   end
end