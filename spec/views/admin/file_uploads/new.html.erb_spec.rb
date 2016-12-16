require 'rails_helper'

RSpec.describe "admin/file_uploads/new", type: :view do
  before(:each) do
    assign(:admin_file_upload, Admin::FileUpload.new(
      :user => nil,
      :file => "MyString"
    ))
  end

  it "renders new admin_file_upload form" do
    render

    assert_select "form[action=?][method=?]", admin_file_uploads_path, "post" do

      assert_select "input#admin_file_upload_user_id[name=?]", "admin_file_upload[user_id]"

      assert_select "input#admin_file_upload_file[name=?]", "admin_file_upload[file]"
    end
  end
end
