require 'rails_helper'

RSpec.describe "admin/file_uploads/show", type: :view do
  before(:each) do
    @admin_file_upload = assign(:admin_file_upload, Admin::FileUpload.create!(
      :user => nil,
      :file => "File"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/File/)
  end
end
