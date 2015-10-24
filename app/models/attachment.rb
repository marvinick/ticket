class Attachment < ActiveRecord::Base
  belongs_to :stub

  mount_uploader :file, AttachmentUploader
end
