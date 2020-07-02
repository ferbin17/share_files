class PaperclipCreateWoker
  include Sidekiq::Worker

  def perform(upload_id)
    upload = Upload.find_by_id(upload_id)
    if upload.present?
      file_sender = upload.file_sender
      File.open(upload.path, 'ab') { |f|
        upload.update(upload_file: f)
        file_sender.update(uploaded_files: file_sender.uploaded_files + 1, uploaded_size: file_sender.uploaded_size + upload.uploaded_size)
      }
      File.delete(upload.path) if File.exist?(upload.path)
      if file_sender.total_files == file_sender.uploaded_files
        DownloadMailWorker.perform_async(file_sender.id)
      end
    end
  end
end