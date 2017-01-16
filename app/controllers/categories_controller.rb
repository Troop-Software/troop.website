class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_leader, except: :show
  before_action :set_category, only: [:show, :edit, :update, :destroy]


  def check_category
    @category = Category.find_by_name(params[:category][:name])

    respond_to do |format|
      format.json { render :json => !@category }
    end
  end

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.search(params[:search])
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html {
          flash[:success] = 'Category was successfully created.'
          redirect_to categories_path
        }
        format.json { render :show, status: :created, location: @category }
        format.js
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html {
          flash[:success] = 'Category was successfully created.'
          redirect_to categories_path
        }
        format.json { render :show, status: :ok, location: @category }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html {
        flash[:danger] = 'Category was successfully destroyed.'
        redirect_to categories_url
      }
      format.json { head :no_content }
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:name)
  end


end
