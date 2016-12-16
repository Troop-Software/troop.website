require 'rails_helper'

RSpec.describe "admin/file_uploads/index", type: :view do
  before(:each) do
    assign(:admin_file_uploads, [
      Admin::FileUpload.create!(
        :user => nil,
        :file => "File"
      ),
      Admin::FileUpload.create!(
        :user => nil,
        :file => "File"
      )
    ])
  end

  it "renders a list of admin/file_uploads" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "File".to_s, :count => 2
  end
end
