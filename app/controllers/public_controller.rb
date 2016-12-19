class PublicController < ApplicationController

  def eagle_roll
    @eagle_scouts = Scout.where(rank_id: 8)
  end
end