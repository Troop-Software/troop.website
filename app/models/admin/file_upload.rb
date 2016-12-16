class Admin::FileUpload < ApplicationRecord
  belongs_to :user

  has_attached_file :file
  validates_with AttachmentPresenceValidator, attributes: :file

  do_not_validate_attachment_file_type :file
  #validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end
