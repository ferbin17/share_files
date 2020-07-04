require 'rubygems'
require 'zip'
class FileSender < ApplicationRecord
  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "User"
  has_many :uploads, dependent: :destroy
  validates_presence_of :sender_id, :receiver_id
  after_create :set_expiry_datetime_and_uuid
  after_destroy :delete_zip
  scope :active, -> { where(is_expired: false) }
  scope :delete_mail_not_sent, -> { where(receiver_delete_mail_sent: false, sender_delete_mail_sent: false) }
  
  def create_zip
    dir  = Rails.root.join('tmp', 'download').to_s
    FileUtils.mkdir_p(dir) unless File.exist?(dir)
    zipfile_name = dir + "/download_#{self.id}.zip"
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      uploads.each do |upload|
        zipfile.add(upload.filename, File.join(upload.upload_file.path.gsub("/#{upload.upload_file_file_name}", ""), upload.upload_file_file_name))
      end
      zipfile
    end
  end
  
  def zip_exists
    dir  = Rails.root.join('tmp', 'download').to_s
    FileUtils.mkdir_p(dir) unless File.exist?(dir)
    zipfile_name = dir + "/download_#{self.id}.zip"
    File.exist?(zipfile_name)
  end
  
  private
    def set_expiry_datetime_and_uuid
      uuid = nil
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
    
    def delete_zip
      dir  = Rails.root.join('tmp', 'download').to_s
      FileUtils.mkdir_p(dir) unless File.exist?(dir)
      zipfile_name = dir + "/download_#{self.id}.zip"
      File.delete(zipfile_name) if File.exist?(zipfile_name)
    end
end
