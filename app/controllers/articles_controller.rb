class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_user_leader, only: [:new, :edit]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.search_title(params[:search]).paginate(page: params[:page], per_page: 5)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = User.find(current_user)


    respond_to do |format|
      if @article.save
        Notification.create(text: @article.title, link: article_path(@article.id), display_until: 2.days.from_now)
        format.html {
          flash[:success] = 'Article was successfully created.'
          redirect_to article_path(@article)
        }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html {
          flash[:success] = 'Article was successfully updated.'
          redirect_to @article
        }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html {
        flash[:danger] = 'Article was successfully destroyed.'
        redirect_to articles_url
      }
      format.json { head :no_content }
    end
  end

  def feed
    @blog_articles = Article.all
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    set_article
    if current_user != @article.user && !(current_user.role? :leader)
      flash[:danger] = 'You can only edit or delete your own articles'
      redirect_to root_path
    end
  end
end
