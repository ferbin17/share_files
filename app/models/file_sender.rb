class FileSender < ApplicationRecord
  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "User"
  has_many :uploads, dependent: :destroy 
  validates_presence_of :sender_id, :receiver_id
  after_create :set_expiry_datetime_and_uuid
  # after_save :mail_download_link, if: Proc.new{|file_sender| file_sender.total_files && file_sender.uploaded_files > 0 && file_sender.total_files == file_sender.uploaded_files}
  
  private
    def set_expiry_datetime_and_uuid
      loop do
        uuid = SecureRandom.uuid.gsub("-", "")
        break unless check_duplicate_uuid(uuid)
      end
      expiry = Time.now + 7.days
      self.update(uuid: uuid, expiry_date: expiry)
    end
    
    def check_duplicate_uuid(uuid)
      uuid_object = FileSender.find_by_uuid(uuid)
      return uuid_object.present?
    end
    
    def mail_download_link
      UploadMailer.with(file_sender: self).send_download_link.deliver_now
    end
end
