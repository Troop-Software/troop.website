require 'rails_helper'

RSpec.describe "ScoutEvents", type: :request do
  describe "GET /scout_events" do
    it "works! (now write some real specs)" do
      get scout_events_path
      expect(response).to have_http_status(200)
    end
  end
end
