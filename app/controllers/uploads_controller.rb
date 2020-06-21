class UploadsController < ApplicationController
  def index
  end
  
  def set_users
    @file_sender = FileSender.new(total_files: params[:total_files], total_file_size: params[:total_file_size])
    set_email_ids
    if @file_sender.save
      render json: { id: @file_sender.id }
    else
      render json: { error: @file_sender.errors }, status: 422
    end
  end
  
  def create
    @file_sender = FileSender.find_by_id(params[:file_sender_id])
    if @file_sender.present?
      filename = params[:filename]
      uuid = SecureRandom.uuid
      ext  = File.extname(filename) if filename.present?
      dir  = Rails.root.join('tmp', 'upload').to_s
      FileUtils.mkdir_p(dir) unless File.exist?(dir)
      @upload = @file_sender.uploads.new(filename: filename, file_size: params[:file_size], path: File.join(dir, "#{uuid}#{ext}"))
      if @file_sender.save
        render json: { id: @upload.id, filename: @upload.filename, uploaded_size: @upload.uploaded_size, file_size: @upload.file_size }
      else
        render json: { error: @upload.errors }, status: 422
      end
    else
      render json: {error: "File Sender not found"}, status: 422
    end
  end
  
  def chunk_create
    file = params[:upload]
    @upload = Upload.find_by(id: params[:id]) 
    @upload.uploaded_size += file.size
    if @upload.save
      File.open(@upload.path, 'ab') { |f|
        f.write(file.read)
        if @upload.uploaded_size == @upload.file_size
          @upload.update(upload_file: f)
          @file_sender = @upload.file_sender
          @file_sender.update(uploaded_files: @file_sender.uploaded_files + 1, uploaded_size: @file_sender.uploaded_size + @upload.uploaded_size)
        end
      }
      render json: { id: @upload.id, filename: @upload.filename, uploaded_size: @upload.uploaded_size, file_size: @upload.file_size }
    else
      render json: { error: @upload.errors }, status: 422
    end
  end
  
  private
    def set_email_ids
      unless @file_sender.sender_id.present?
        @sender = User.find_or_create_by(email_id: params[:sender_email])
        @file_sender.update(sender_id: @sender.id)
      end
      unless @file_sender.receiver_id.present?
        @receiver = User.find_or_create_by(email_id: params[:receiver_email])
        @file_sender.update(receiver_id: @receiver.id)
      end
    end
end
