class AddFiletoAdminFileUploads < ActiveRecord::Migration[5.0]
  def change
    add_attachment :admin_file_uploads, :file
  end
end
