class DownloadMailWorker
  include Sidekiq::Worker

  def perform(file_sender_id)
    file_sender = FileSender.active.find_by_id(file_sender_id)
    if file_sender.present?
      sender = file_sender.sender
      sender.update(upload_count: sender.upload_count + file_sender.total_files.to_i)
      UploadMailer.with(file_sender: file_sender).send_download_link.deliver_now
      UploadMailer.with(file_sender: file_sender).send_success_mail.deliver_now
    end
  end
end