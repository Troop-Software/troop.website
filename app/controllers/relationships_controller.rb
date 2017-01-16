class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_leader_full
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def index
    relationships = Relationship.user_sort.all
    @relationships_group = relationships.group_by(&:user_id)

  end

  def show
  end

  def new
    @relationship = Relationship.new
  end

  def update
    respond_to do |format|
      if @relationship.update(relationship_params)
        format.html {
          flash[:success] = 'User was successfully updated.'
          redirect_to relationships_path
        }
        format.json { render :show, status: :ok, location: relationships_path }
      else
        format.html { render :edit }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @relationship = Relationship.new(relationship_params)

    respond_to do |format|
      if @relationship.save
        format.html {
          flash[:success] = 'Relationship was successfully created.'
          redirect_to relationships_path
        }
        format.json { render :show, status: :created, location: relationships_path }
      else
        format.html { render :new }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @relationship.destroy
    respond_to do |format|
      format.html {
        flash[:danger] = 'Relationship was successfully destroyed.'
        redirect_to relationships_path
      }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_user
    @relationship = Relationship.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def relationship_params
    params.require(:relationship).permit(:scout_id, :user_id)
  end
end