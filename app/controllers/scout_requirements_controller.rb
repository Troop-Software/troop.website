class ScoutRequirementsController < ApplicationController
  before_action :set_scout_requirement, only: [:show, :edit, :update, :destroy]

  # GET /scout_requirements
  # GET /scout_requirements.json
  def index
    @scout_requirements = ScoutRequirement.all
  end

  # GET /scout_requirements/1
  # GET /scout_requirements/1.json
  def show
  end

  # GET /scout_requirements/new
  def new
    @scout_requirement = ScoutRequirement.new(scout_id: params[:scout_id], requirement_id: params[:req_id])
  end

  # GET /scout_requirements/1/edit
  def edit
  end

  # POST /scout_requirements
  # POST /scout_requirements.json
  def create
    @scout_requirement = ScoutRequirement.new(scout_requirement_params)
    mark_rank_completed_after_bor

    respond_to do |format|
      if @scout_requirement.save
     #  format.html { redirect_to @scout_requirement, notice: 'Scout requirement was successfully created.' }
     #   format.json { render :show, status: :created, location: @scout_requirement }
        format.json { head :no_content }
        format.js
      else
        format.html { render :new }
        format.json { render json: @scout_requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scout_requirements/1
  # PATCH/PUT /scout_requirements/1.json
  def update
    respond_to do |format|
      if @scout_requirement.update(scout_requirement_params)
        format.html { redirect_to @scout_requirement, notice: 'Scout requirement was successfully updated.' }
        format.json { render :show, status: :ok, location: @scout_requirement }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @scout_requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scout_requirements/1
  # DELETE /scout_requirements/1.json
  def destroy
    @scout_requirement.destroy
    respond_to do |format|
      format.html { redirect_to scout_requirements_url, notice: 'Scout requirement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scout_requirement
      @scout_requirement = ScoutRequirement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scout_requirement_params
      params.require(:scout_requirement).permit(:scout_id, :requirement_id, :sign_off, :completed_date)
    end

  def mark_rank_completed_after_bor

    if @scout_requirement.requirement.bor
      # Mark rank completed
      active_rank = Requirement.find(@scout_requirement.requirement_id).rank_id
      mark_rank = ScoutRankHistory.new(scout_id: @scout_requirement.scout_id,
                                       rank_id: active_rank)
      mark_rank.rank_completed = @scout_requirement.completed_date
      mark_rank.save

      # Mark all requirement completed
      requirements= Requirement.where(rank_id: active_rank)
      requirements.each do |req|
        # check if record exists for requirement
        unless ScoutRequirement.where(scout_id: @scout_requirement.scout_id, requirement_id: req.id).exists?

          ScoutRequirement.create(scout_id: @scout_requirement.scout_id,
                                  requirement_id: req.id,
                                  sign_off: @scout_requirement.sign_off,
                                  completed_date: @scout_requirement.completed_date)
        end

      end

      # Advance to next rank
      current_scout = Scout.find(@scout_requirement.scout_id)
      if active_rank - 1 == current_scout.rank_id
        current_scout.rank_id += 1
        current_scout.save
      end

    end
  end

end
