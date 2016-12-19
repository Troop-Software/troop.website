class StaticPagesController < ApplicationController
  
  def home
    @articles = Article.search_title(params[:search]).paginate(page: params[:page], per_page: 8).order('updated_at DESC')
  end

end
