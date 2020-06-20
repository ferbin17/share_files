class UploadsController < ApplicationController
  def index
  end
  
  def create
    filename = params[:filename]
    uuid = SecureRandom.uuid
    ext  = File.extname(filename) if filename.present?
    dir  = Rails.root.join('tmp', 'upload').to_s
    FileUtils.mkdir_p(dir) unless File.exist?(dir)
    @upload = Upload.new(filename: filename, file_size: params[:file_size], path: File.join(dir, "#{uuid}#{ext}"))
    if @upload.save
      render json: { id: @upload.id, uploaded_size: @upload.uploaded_size }
    else
      render json: { error: @upload.errors }
    end
  end
  
  def chunk_create
    file = params[:upload]
    @upload = Upload.find_by(id: params[:id])
    set_email_ids 
    @upload.uploaded_size += file.size
    if @upload.save
      File.open(@upload.path, 'ab') { |f|
        f.write(file.read)
        if @upload.uploaded_size == @upload.file_size
          @upload.update(upload_file: f)
        end
      }
      render json: { id: @upload.id, uploaded_size: @upload.uploaded_size }
    else
      render json: { error: @upload.errors }, status: 422
    end
  end
  
  private
    def set_email_ids
      unless @upload.sender_id.present?
        @sender = User.find_or_create_by(email_id: params[:sender_email])
        @upload.update(sender_id: @sender.id)
      end
      unless @upload.receiver_id.present?
        @receiver = User.find_or_create_by(email_id: params[:receiver_email])
        @upload.update(receiver_id: @receiver.id)
      end
    end
end
