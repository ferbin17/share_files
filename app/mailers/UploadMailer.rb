class UploadMailer < ApplicationMailer
  default from: 'ferbinupworkprojects@gmail.com'
  
  def send_download_link
    @file = params[:file]
    @receiver = @file.receiver
    @sender = @file.sender
    @url = ENV['ROOT_URL'] + '/downloads/' + @file.uuid
    @file.update(mail_sent: true)
    mail(to: @receiver.email_id, subject: 'ShareFile download link')
  end
end
