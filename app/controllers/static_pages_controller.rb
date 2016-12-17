class StaticPagesController < ApplicationController

  layout 'application', only: [:home]
  layout 'public', only: [:public_home, :public_join_our_troop]

  def home
    @articles = Article.paginate(page: params[:page], per_page: 8).order('updated_at DESC')
  end


end
