require "rails_helper"

RSpec.describe ScoutTrainingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/scout_trainings").to route_to("scout_trainings#index")
    end

    it "routes to #new" do
      expect(:get => "/scout_trainings/new").to route_to("scout_trainings#new")
    end

    it "routes to #show" do
      expect(:get => "/scout_trainings/1").to route_to("scout_trainings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/scout_trainings/1/edit").to route_to("scout_trainings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/scout_trainings").to route_to("scout_trainings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/scout_trainings/1").to route_to("scout_trainings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/scout_trainings/1").to route_to("scout_trainings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/scout_trainings/1").to route_to("scout_trainings#destroy", :id => "1")
    end

  end
end
