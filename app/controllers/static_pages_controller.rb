class StaticPagesController < ApplicationController
  def show
    @hello = "Hello world!"
    # CountAccessWorker.perform_async
    # AdminMailer.send_mail_to("vanuy113@gmail.com").deliver_now
  end
end
