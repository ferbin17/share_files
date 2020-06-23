class DownloadsController < ApplicationController
  def show
    @file_sender = FileSender.find_by_uuid(params[:id])
    if @file_sender.present?
      @uploads = @file_sender.uploads
    else
      flash[:danger] = "Invalid URL"
      redirect_to :root
    end
  end
  
  def download
    @upload = Upload.find_by_uuid(params[:id])
    if @upload.present?
      send_file @upload.upload_file.path, filename: @upload.filename,  type: @upload.upload_file_content_type, disposition: 'inline'
    else
      flash[:danger] = "Invalid URL"
      redirect_to :root
    end
  end
  
  def download_as_zip
    @file_sender = FileSender.find_by_uuid(params[:id])
    if @file_sender.present?
      path = 
        if @file_sender.zip_exists
          "#{Rails.root}/tmp/download/download_#{@file_sender.id}.zip" 
        else
          @file_sender.create_zip.name
        end
      send_file path, filename: "download_#{@file_sender.id}.zip", disposition: 'inline'
    else
      flash[:danger] = "Invalid URL"
      redirect_to :root
    end
  end
  
  private
end
