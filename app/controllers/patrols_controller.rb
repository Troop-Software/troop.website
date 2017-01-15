class PatrolsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_leader
  before_action :set_patrol, only: [:show, :edit, :update, :destroy]


  # GET /patrols
  # GET /patrols.json
  def index
    @patrols = Patrol.search(params[:search])
  end

  # GET /patrols/1
  # GET /patrols/1.json
  def show
  end

  # GET /patrols/new
  def new
    @patrol = Patrol.new
  end

  # GET /patrols/1/edit
  def edit
  end

  # POST /patrols
  # POST /patrols.json
  def create
    @patrol = Patrol.new(patrol_params)

    respond_to do |format|
      if @patrol.save
        format.html {
          flash[:success] = 'Patrol was successfully created.'
          redirect_to patrols_path
        }
        format.json { render :show, status: :created, location: @patrol }
      else
        format.html { render :new }
        format.json { render json: @patrol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patrols/1
  # PATCH/PUT /patrols/1.json
  def update
    respond_to do |format|
      if @patrol.update(patrol_params)
        format.html {
          flash[:success] = 'Patrol was successfully renamed.'
          redirect_to patrols_path
        }
        format.json { render :show, status: :ok, location: @patrol }
      else
        format.html { render :edit }
        format.json { render json: @patrol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patrols/1
  # DELETE /patrols/1.json
  def destroy
    @patrol.destroy
    respond_to do |format|
      format.html {
        flash[:danger] = 'Patrol was successfully destroyed.'
        redirect_to patrols_url
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patrol
      @patrol = Patrol.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patrol_params
      params.require(:patrol).permit(:name)
    end

end
