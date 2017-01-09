class AdultsController < ApplicationController
  before_action :set_adult, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_user_leader_full


  def new
    @adult = Adult.new
    @adult.build_address
  end

  def edit
    @adult.build_address if @adult.address.blank?
  end

  def show
  end

  def index
    @adults = Adult.search(params[:id])
  end

  def update
    respond_to do |format|
      if @adult.update(adult_params)
        format.html {
          flash[:success] = 'Adult was successfully updated.'
          redirect_to adults_path
        }
        format.json { render :show, status: :ok, location: @adult }
      else
        format.html { render :edit }
        format.json { render json: @adult.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @adult = Adult.new(adult_params)
    user_link = User.find_by_email(@adult.email)
    unless user_link.blank?
      @adult.user_id = user_link.id
    end

    respond_to do |format|
      if @adult.save
        format.html {
          flash[:success] = 'Position was successfully created.'
          redirect_to adults_path
        }
        format.json { render :show, status: :created, location: @adult }
      else
        format.html { render :new }
        format.json { render json: @adult.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_adult
    @adult = Adult.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def adult_params
    params.require(:adult).permit(:name, :sex, :email, :phone, :bsa_id, :dob,
                                  :drivers_license, :joined, :became_leader, :inactive,
                                  :user_id, address_attributes: [:line1, :line2, :city, :state, :zip,
                                                      :addressable_id, :addressable_type])
  end

end
