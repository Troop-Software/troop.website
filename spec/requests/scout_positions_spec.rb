require 'rails_helper'

RSpec.describe "ScoutPositions", type: :request do
  describe "GET /scout_positions" do
    it "works! (now write some real specs)" do
      get scout_positions_path
      expect(response).to have_http_status(200)
    end
  end
end
