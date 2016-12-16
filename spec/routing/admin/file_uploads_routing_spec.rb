require "rails_helper"

RSpec.describe Admin::FileUploadsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/file_uploads").to route_to("admin/file_uploads#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/file_uploads/new").to route_to("admin/file_uploads#new")
    end

    it "routes to #create" do
      expect(:post => "/admin/file_uploads").to route_to("admin/file_uploads#create")
    end


    it "routes to #destroy" do
      expect(:delete => "/admin/file_uploads/1").to route_to("admin/file_uploads#destroy", :id => "1")
    end

  end
end
