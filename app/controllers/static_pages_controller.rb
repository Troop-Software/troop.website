class StaticPagesController < ApplicationController

  layout 'application', only: [:home]

  def home
    @articles = Article.paginate(page: params[:page], per_page: 8).order('updated_at DESC')
  end

end
