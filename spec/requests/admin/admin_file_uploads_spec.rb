require 'rails_helper'

RSpec.describe "Admin::FileUploads", type: :request do
  describe "GET /admin_file_uploads" do
    it "works! (now write some real specs)" do
      get admin_file_uploads_path
      expect(response).to have_http_status(200)
    end
  end
end
