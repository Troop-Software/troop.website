require "rails_helper"

RSpec.describe ScoutRequirementsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/scout_requirements").to route_to("scout_requirements#index")
    end

    it "routes to #new" do
      expect(:get => "/scout_requirements/new").to route_to("scout_requirements#new")
    end

    it "routes to #show" do
      expect(:get => "/scout_requirements/1").to route_to("scout_requirements#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/scout_requirements/1/edit").to route_to("scout_requirements#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/scout_requirements").to route_to("scout_requirements#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/scout_requirements/1").to route_to("scout_requirements#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/scout_requirements/1").to route_to("scout_requirements#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/scout_requirements/1").to route_to("scout_requirements#destroy", :id => "1")
    end

  end
end
