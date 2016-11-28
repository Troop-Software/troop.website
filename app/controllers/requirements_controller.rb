class RequirementsController < ApplicationController
  before_action :set_requirement, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  #before_action :require_admin_user, only: [:create, :edit, :update, :destroy]

  has_scope :by_rank_id


  # GET /requirements
  # GET /requirements.json
  def index
    @requirements = apply_scopes(Requirement).paginate(page: params[:page], per_page: 38).order('sortOrder,rank_id ASC')
    @rank = Rank.find(params[:by_rank_id]).name unless params[:by_rank_id].nil?
  end

  # GET /requirements/1
  # GET /requirements/1.json
  def show
  end

  # GET /requirements/new
  def new
    @requirement = Requirement.new
  end

  # GET /requirements/1/edit
  def edit
  end

  # POST /requirements
  # POST /requirements.json
  def create
    @requirement = Requirement.new(requirement_params)

    respond_to do |format|
      if @requirement.save
        format.html {
          flash[:success] = 'Rank was successfully created.'
          redirect_to @requirement
        }
        format.json { render :show, status: :created, location: @requirement }
      else
        format.html { render :new }
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requirements/1
  # PATCH/PUT /requirements/1.json
  def update
    respond_to do |format|
      if @requirement.update(requirement_params)
        format.html {
          flash[:success] = 'Rank was successfully created.'
          redirect_to @requirement
        }
        format.json { render :show, status: :ok, location: @requirement }
      else
        format.html { render :edit }
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requirements/1
  # DELETE /requirements/1.json
  def destroy
    @requirement.destroy
    respond_to do |format|
      format.html {
        flash[:danger] = 'Rank was successfully deleted.'
        redirect_to requirements_url
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requirement
      @requirement = Requirement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requirement_params
      params.require(:requirement).permit(:revision, :rank_id, :req_category, :req_num, :description)
    end

  def require_admin_user
    if !current_user.admin?
      flash[:danger] = 'Sorry you do not have permissions to modify requirements'
      redirect_to requirements_path
    end
  end
end
