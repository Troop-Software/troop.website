class StaticPagesController < ApplicationController
<<<<<<< HEAD
  
=======

  layout 'application', only: [:home]

>>>>>>> 0493e8c... publc / private routing and controllers setup
  def home
    @articles = Article.search_title(params[:search]).paginate(page: params[:page], per_page: 8).order('updated_at DESC')
  end

end
