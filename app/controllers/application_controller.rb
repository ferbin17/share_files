class ApplicationController < ActionController::Base
  # rescue_from ActiveRecord::RecordNotFound, with: :not_found 
  # rescue_from Exception, with: :not_found
  # rescue_from ActionController::RoutingError, with: :not_found
  # 
  # def raise_not_found
  #   raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  # end
  # 
  # def not_found
  #   flash[:notice] = "Page not found"
  #   respond_to do |format|
  #     format.html { redirect_to :root }
  #     format.xml { head :not_found }
  #     format.any { head :not_found }
  #   end
  # end
  # 
  # def error
  #   flash[:notice] = "Encountered some error. Sorry for the inconvenience"
  #   respond_to do |format|
  #     format.html { redirect_to :root }
  #     format.xml { head :not_found }
  #     format.any { head :not_found }
  #   end
  # end
end
