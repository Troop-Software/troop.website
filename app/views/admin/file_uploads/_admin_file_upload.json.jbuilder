json.extract! admin_file_upload, :id, :user_id, :file, :created_at, :updated_at
json.url admin_file_upload_url(admin_file_upload, format: :json)