require "rails_helper"

RSpec.describe ScoutEventsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/scout_events").to route_to("scout_events#index")
    end

    it "routes to #new" do
      expect(:get => "/scout_events/new").to route_to("scout_events#new")
    end

    it "routes to #show" do
      expect(:get => "/scout_events/1").to route_to("scout_events#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/scout_events/1/edit").to route_to("scout_events#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/scout_events").to route_to("scout_events#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/scout_events/1").to route_to("scout_events#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/scout_events/1").to route_to("scout_events#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/scout_events/1").to route_to("scout_events#destroy", :id => "1")
    end

  end
end
