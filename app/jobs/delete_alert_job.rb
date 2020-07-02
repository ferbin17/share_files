class DeleteAlertJob < ActiveJob::Base
  queue_as :default

  def perform
    FileSender.active.delete_mail_not_sent.each do |file_sender|
      flag = (file_sender.expiry_date >= Time.now + 1.days) && (file_sender.expiry_date <= Time.now + 2.days)
      if flag
        time = file_sender.expiry_date - 24.hours
        if time < Time.now
          time =Time.now + 5.minutes
        end
        DeleteAlertMailWorker.perform_at(time, file_sender.id)
      end
    end
  end
end