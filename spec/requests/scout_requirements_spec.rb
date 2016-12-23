require 'rails_helper'

RSpec.describe "ScoutRequirements", type: :request do
  describe "GET /scout_requirements" do
    it "works! (now write some real specs)" do
      get scout_requirements_path
      expect(response).to have_http_status(200)
    end
  end
end
