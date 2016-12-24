require "rails_helper"

RSpec.describe ScoutPositionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/scout_positions").to route_to("scout_positions#index")
    end

    it "routes to #new" do
      expect(:get => "/scout_positions/new").to route_to("scout_positions#new")
    end

    it "routes to #show" do
      expect(:get => "/scout_positions/1").to route_to("scout_positions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/scout_positions/1/edit").to route_to("scout_positions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/scout_positions").to route_to("scout_positions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/scout_positions/1").to route_to("scout_positions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/scout_positions/1").to route_to("scout_positions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/scout_positions/1").to route_to("scout_positions#destroy", :id => "1")
    end

  end
end
