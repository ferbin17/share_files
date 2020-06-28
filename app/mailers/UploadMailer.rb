class UploadMailer < ApplicationMailer
  default from: 'ferbinupworkprojects@gmail.com'
  
  def send_download_link
    @file = params[:file_sender]
    @sender = @file.sender
    @receiver = @file.receiver
    @url = AppConfig["host_config"]["host_url"] + '/downloads/' + @file.uuid
    @file.update(receiver_mail_sent: true)
    mail(to: @receiver.email_id, subject: 'ShareFile download link')
  end
  
  def send_success_mail
    @file = params[:file_sender]
    @sender = @file.sender
    @receiver = @file.receiver
    @url = AppConfig["host_config"]["host_url"] + '/downloads/' + @file.uuid
    @file.update(sender_mail_sent: true)
    mail(to: @sender.email_id, subject: 'ShareFile download link sent')
  end
  
  def sender_delete_alert
    @file = params[:file_sender]
    @sender = @file.sender
    @receiver = @file.receiver
    @url = AppConfig["host_config"]["host_url"] + '/downloads/' + @file.uuid
    @file.update(sender_mail_sent: true)
    mail(to: @sender.email_id, subject: 'ShareFile file delte alert')
  end
  
  def receiver_delete_alert
    @file = params[:file_sender]
    @sender = @file.sender
    @receiver = @file.receiver
    @url = AppConfig["host_config"]["host_url"] + '/downloads/' + @file.uuid
    @file.update(sender_mail_sent: true)
    mail(to: @receiver.email_id, subject: 'ShareFile file delte alert')
  end
end
