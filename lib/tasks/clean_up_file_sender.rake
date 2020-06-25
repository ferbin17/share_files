namespace :share_file do
  desc 'Clean up expired or broken filesenders'
  task :clean_up_file_senders => :environment do
    log = Logger.new('log/clean_up_file_senders.log')
    start_time = Time.now
    log.info "Clean up Started at #{start_time}"
    FileSender.where("expiry_date < '#{Time.now}'").destroy_all
    broken_uplaods = Upload.where("uploaded_size != file_size and updated_at < '#{Time.now + 1.hours}'")
    broken_uplaods.each do |upload|
      upload.file_sender.destroy if upload.file_sender.present?
    end
    end_time = Time.now
    duration = end_time - start_time
    log.info "Clean up Started at #{end_time}"    
    log.info "Clean up Total Time Duration #{duration/60} mins"
  end
end