require 'rails_helper'

RSpec.describe "ScoutTrainings", type: :request do
  describe "GET /scout_trainings" do
    it "works! (now write some real specs)" do
      get scout_trainings_path
      expect(response).to have_http_status(200)
    end
  end
end
