require 'rails_helper'

RSpec.describe "EventLocations", type: :request do
  describe "GET /event_locations" do
    it "works! (now write some real specs)" do
      get event_locations_path
      expect(response).to have_http_status(200)
    end
  end
end
