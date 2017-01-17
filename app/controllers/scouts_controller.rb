class ScoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_leader, except: [:show]
  before_action :set_scout, only: [:show, :edit, :update, :destroy]


  # GET /scouts
  # GET /scouts.json
  def index
    @scouts = Scout.search(params[:search]).where(active: true).paginate(page: params[:page], per_page: 8)
    @scouts = Scout.search(params[:search]).paginate(page: params[:page], per_page: 8) if current_user.show_inactive_scouts

    respond_to do |format|
      format.html
      format.csv { send_data Scout.all.to_csv('scoutsReport'), filename: "scouts-#{Date.today}.csv" }
      format.json { render :index, status: :ok, location: @scout_path }
    end
  end

  def show_inactive
    @scouts = Scout.where(active: false)
  end

  # GET /scouts/1
  # GET /scouts/1.json
  def show
    @ranks = Rank.all
  end

  # GET /scouts/new
  def new
    @scout = Scout.new
    @scout.build_address
  end

  # GET /scouts/1/edit
  def edit
    @scout.build_address if @scout.address.blank?
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
   if params[:active]
     @scout.active = true
     @scout.save
     redirect_to show_inactive_scouts_path and return
   end
    respond_to do |format|
      if @scout.update(scout_params)
        format.html {
          flash[:success] = 'Scout was successfully updated.'
          if @scout.active?
            redirect_to @scout
          else
            redirect_to scouts_path
          end
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
    if params[:active]
      @scout = Scout.find(params[:id])
    else
      @scout = Scout.where(active: true).find(params[:id])
    end

  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def scout_params
    params.require(:scout).permit(:name, :grade, :birthdate, :patrol_id, :rank_id, :position_id, :email,
                                  :phone, :joined, :bsa_id, :active,
                                  address_attributes: [:line1, :line2, :city, :state, :zip,
                                                       :addressable_id, :addressable_type]
    )
  end

end