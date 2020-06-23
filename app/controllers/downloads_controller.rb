class DownloadsController < ApplicationController
  before_action :find_file_sender_and_check_expiry, only: [:show, :download_as_zip]
  before_action :find_upload_and_check_expiry, only: [:download]
  def show
    @uploads = @file_sender.uploads
  end
  
  def download
    send_file @upload.upload_file.path, filename: @upload.filename,  type: @upload.upload_file_content_type, disposition: 'inline'
  end
  
  def download_as_zip
    path = 
      if @file_sender.zip_exists
        "#{Rails.root}/tmp/download/download_#{@file_sender.id}.zip" 
      else
        @file_sender.create_zip.name
      end
    send_file path, filename: "download_#{@file_sender.id}.zip", disposition: 'inline'
  end
  
  private
    def find_file_sender_and_check_expiry
      @file_sender = FileSender.find_by_uuid(params[:id])
      if @file_sender.present?
        if @file_sender.expiry_date < Time.now
          @file_sender.destroy
          flash[:danger] = "Link expired"
          redirect_to :root
        end
      else
        flash[:danger] = "Invalid URL"
        redirect_to :root
      end
    end
    
    def find_upload_and_check_expiry
      @upload = Upload.find_by_uuid(params[:id])
      if @upload.present?
        file_sender = @upload.file_sender
        if file_sender.expiry_date < Time.now
          file_sender.destroy
          flash[:danger] = "Link expired"
          redirect_to :root
        end
      else
        flash[:danger] = "Invalid URL"
        redirect_to :root
      end
    end
end
