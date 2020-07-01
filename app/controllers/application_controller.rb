class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_record_found 
  rescue_from Exception, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found
  before_action :find_carousels
  def raise_not_found
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end
  
  def not_found
    flash[:notice] = "Page not found"
    respond_to do |format|
      format.html { render file: Rails.public_path.join('404.html'), status: :not_found, layout: false }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end
  
  def not_record_found
    flash[:notice] = "No record found with ID"
    respond_to do |format|
      format.html { redirect_to :root }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end
  
  def error
    flash[:notice] = "Encountered some error. Sorry for the inconvenience"
    respond_to do |format|
      format.html { render file: Rails.public_path.join('500.html'), status: :not_found, layout: false }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end
  
  private
    def find_carousels
      files = Dir.entries("#{Rails.root}/app/assets/images/carousel/")
      @files = files.select{|f| f.split(".").last == "jpg"}.sort
      @text = {}
      if File.exist?("#{Rails.root}/app/assets/images/carousel/carousel.yml")
        @text = YAML.load_file("#{Rails.root}/app/assets/images/carousel/carousel.yml")
      end
    end
end
