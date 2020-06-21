class UploadMailer < ApplicationMailer
  default from: 'ferbinupworkprojects@gmail.com'
  
  def send_download_link
    @file = params[:file_sender]
    @receiver = @file.receiver
    @sender = @file.sender
    @url = ENV['ROOT_URL'] + '/downloads/' + @file.uuid
    @file.update(receiver_mail_sent: true)
    mail(to: @receiver.email_id, subject: 'ShareFile download link')
  end
  
  def send_success_mail
    @file = params[:file_sender]
    @receiver = @file.receiver
    @sender = @file.sender
    @url = ENV['ROOT_URL'] + '/downloads/' + @file.uuid
    @file.update(sender_mail_sent: true)
    mail(to: @sender.email_id, subject: 'ShareFile download link sent')
  end
end
