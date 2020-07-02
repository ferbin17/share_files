class DeleteAlertMailerJob < ApplicationJob
  queue_as :default

  def perform
    DeleteAlertJob.perform
  end
end