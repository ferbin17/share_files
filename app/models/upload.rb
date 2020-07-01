class Upload < ApplicationRecord
  belongs_to :file_sender
  validates_presence_of :filename, :path, :file_size
  after_create :set_uuid
  after_destroy :delete_upload_file
  has_attached_file :upload_file
  do_not_validate_attachment_file_type :upload_file
  
  private
    def set_uuid
      uuid = nil
      loop do
        uuid = SecureRandom.uuid.gsub("-", "")
        break unless check_duplicate_uuid(uuid)
      end
      self.update(uuid: uuid)
    end
    
    def check_duplicate_uuid(uuid)
      uuid_object = Upload.find_by_uuid(uuid)
      return uuid_object.present?
    end
    
    def delete_temp_file
      File.delete(path) if File.exist?(path)
    end
    
    def delete_upload_file
      delete_temp_file
      upload_file.destroy if upload_file.present?
    end
end
