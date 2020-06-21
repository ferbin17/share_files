class Upload < ApplicationRecord
  belongs_to :file_sender
  validates_presence_of :filename, :path, :file_size
  after_save :delete_temp_file, if: Proc.new{|upload| upload.upload_file.present? && File.exist?(upload.path)}
  after_destroy :delete_upload_file
  has_attached_file :upload_file
  do_not_validate_attachment_file_type :upload_file
  
  private
    def delete_temp_file
      File.delete(path) if File.exist?(path)
    end
    
    def delete_upload_file
      delete_temp_file
      upload_file.destroy if upload_file.present?
    end
end
