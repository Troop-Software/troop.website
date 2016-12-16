require 'rails_helper'

RSpec.describe "admin/file_uploads/edit", type: :view do
  before(:each) do
    @admin_file_upload = assign(:admin_file_upload, Admin::FileUpload.create!(
      :user => nil,
      :file => "MyString"
    ))
  end

  it "renders the edit admin_file_upload form" do
    render

    assert_select "form[action=?][method=?]", admin_file_upload_path(@admin_file_upload), "post" do

      assert_select "input#admin_file_upload_user_id[name=?]", "admin_file_upload[user_id]"

      assert_select "input#admin_file_upload_file[name=?]", "admin_file_upload[file]"
    end
  end
end
