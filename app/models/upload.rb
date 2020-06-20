class Upload < ApplicationRecord
  belongs_to :receiver, class_name: "User", optional: true
  belongs_to :sender, class_name: "User", optional: true
  validates_presence_of :filename, :path, :file_size
  after_create :set_expiry_datetime
  after_save :set_uuid, if: Proc.new{|upload| upload.upload_file.present? && !upload.uuid.present?}
  after_save :delete_temp_file, if: Proc.new{|upload| upload.upload_file.present? && File.exist?(upload.path)}
  after_save :mail_download_link, if: Proc.new{|upload| upload.upload_file.present? && !upload.mail_sent}
  after_destroy :delete_upload_file
  has_attached_file :upload_file
  do_not_validate_attachment_file_type :upload_file
  
  private
    def set_expiry_datetime
      self.expiry_date = Time.now
      self.save
    end
    
    def set_uuid
      uuid = upload_file_file_name.gsub("-", "").slice(0, 10)
      while check_duplicate_uuid(uuid) do
        uuid = SecureRandom.uuid.gsub("-", "").slice(0, 10)
      end
      self.update(uuid: uuid)
    end
    
    def delete_temp_file
      File.delete(path) if File.exist?(path)
    end
    
    def delete_upload_file
      delete_temp_file
      upload_file.destroy if upload_file.present?
    end
    
    def mail_download_link
      UploadMailer.with(file: self).send_download_link.deliver_now
    end
    
    def check_duplicate_uuid(uuid)
      uuid_object = Upload.find_by_uuid(uuid)
      return uuid_object.present?
    end
end
