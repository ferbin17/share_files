class UploadMailer < ApplicationMailer
  default from: 'notifications@example.com'
  
  def send_download_link
    @file = params[:file]
    @receiver = @file.receiver
    @sender = @file.sender
    @url = 'http://localhost:3000/downloads/' + @file.uuid
    @file.update(mail_sent: true)
    mail(to: @receiver.email_id, subject: 'ShareFile download link')
  end
end
