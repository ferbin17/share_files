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
    @file_sender = FileSender.active.find_by_id(params[:file_sender_id])
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
    @file_sender = @upload.file_sender
    @upload.uploaded_size += file.size
    if @upload.save
      File.open(@upload.path, 'ab') { |f|
        f.write(file.read)
      }
      if @upload.uploaded_size == @upload.file_size
        PaperclipCreateWoker.perform_async(@upload.id)
      end
      if @file_sender.total_files == @file_sender.uploaded_files
        DownloadMailWorker.perform_async(@file_sender.id)
      end
      render json: { id: @upload.id, filename: @upload.filename, uploaded_size: @upload.uploaded_size, file_size: @upload.file_size }
    else
      render json: { error: @upload.errors }, status: 422
    end
  end
  
  def cancel_upload
    if params[:file_sender_id].present?
      @file_sender = FileSender.active.find_by_id(params[:file_sender_id])
    elsif params[:file_id].present?
      @file = Upload.find_by_id(params[:file_id])
    else
    end
    result =
      if @file_sender.present?
        @file_sender.destroy
      elsif @file.present?
        @file_sender = @file.file_sender
        if @file.destroy
          @file_sender.update(total_file_size: @file_sender.total_file_size - @file.file_size, total_files: @file_sender.total_files - 1)
        end
      else
        false
      end
    render json: { result:  result}, status: 200
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
