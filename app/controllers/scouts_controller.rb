class ScoutsController < ApplicationController
  before_action :set_scout, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_user_leader, only: [:create, :edit, :update, :destroy]

  helper_method :scout_activities

  def scout_activities
    ScoutEvent.where(scout_id: params[:id]).joins(:event).order('events.start DESC')
  end

  # GET /scouts
  # GET /scouts.json
  def index
    @scouts = Scout.paginate(page: params[:page], per_page: 8)

    respond_to do |format|
      format.html
      format.csv { send_data Scout.all.to_csv('scoutsReport'), filename: "scouts-#{Date.today}.csv" }
      format.json { render :index, status: :ok, location: @scout_path }
    end
  end

  # GET /scouts/1
  # GET /scouts/1.json
  def show
   @ranks = Rank.all
  end

  # GET /scouts/new
  def new
    @scout = Scout.new
  end

  # GET /scouts/1/edit
  def edit
  end

  # POST /scouts
  # POST /scouts.json
  def create
    @scout = Scout.new(scout_params)

    respond_to do |format|
      if @scout.save
        format.html {
          flash[:success] = 'Scout was successfully created.'
          redirect_to @scout
        }
        format.json { render :show, status: :created, location: @scout }
      else
        format.html { render :new }
        format.json { render json: @scout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scouts/1
  # PATCH/PUT /scouts/1.json
  def update
    respond_to do |format|
      if @scout.update(scout_params)
        format.html {
          flash[:success] = 'Scout was successfully updated.'
          redirect_to @scout
        }
        format.json { render :show, status: :ok, location: @scout }
      else
        format.html { render :edit }
        format.json { render json: @scout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scouts/1
  # DELETE /scouts/1.json
  def destroy
    @scout.destroy
    respond_to do |format|
      format.html {
        flash[:danger]= 'Scout was successfully deleted.'
        redirect_to scouts_url
      }
      format.json { head :no_content }
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_scout
    @scout = Scout.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def scout_params
    params.require(:scout).permit(:name, :grade, :birthdate, :patrol_id, :rank_id, :position_id, :email,
                                  :phone, :joined, :bsa_id)
  end


end