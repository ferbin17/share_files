class AddAttachmentToUpload < ActiveRecord::Migration[6.0]
  def change
    add_attachment :uploads, :upload_file
  end
end
