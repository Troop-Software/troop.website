class StaticPagesController < ApplicationController

  layout 'application', only: [:home]
  layout 'public', only: [:public_home]

  def home
    @articles = Article.paginate(page: params[:page], per_page: 8).order('updated_at DESC')
  end

  def public_home

  end
end
