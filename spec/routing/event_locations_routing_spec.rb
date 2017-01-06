require "rails_helper"

RSpec.describe EventLocationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/event_locations").to route_to("event_locations#index")
    end

    it "routes to #new" do
      expect(:get => "/event_locations/new").to route_to("event_locations#new")
    end

    it "routes to #show" do
      expect(:get => "/event_locations/1").to route_to("event_locations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/event_locations/1/edit").to route_to("event_locations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/event_locations").to route_to("event_locations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/event_locations/1").to route_to("event_locations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/event_locations/1").to route_to("event_locations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/event_locations/1").to route_to("event_locations#destroy", :id => "1")
    end

  end
end
