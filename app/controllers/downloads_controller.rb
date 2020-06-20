class DownloadsController < ApplicationController

  def show
    @upload = Upload.find_by_uuid(params[:id])
    if @upload.present?
      send_file @upload.upload_file.path, filename: @upload.filename,  type: @upload.upload_file_content_type, disposition: 'inline'
    else
      flash[:danger] = "Invalid URL"
      redirect_to :root
    end
  end
end
