class AdminMailer < ApplicationMailer
  def send_mail_to mail
    mail(to: mail, subject: "Hello #{mail}!")
  end
end
