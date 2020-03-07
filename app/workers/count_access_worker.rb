class CountAccessWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def perform
    logger = Logger.new Rails.root.join("log", "access_web.log")
    logger.info("=>> Accessed at: #{Time.now}")
  end
end
