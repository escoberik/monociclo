class AdminMailer < ActionMailer::Base
  default from: "contacto@1808.com.mx"
  
  def contact_mail(mail)
    @mail = mail
    mail(:to => "admin@1808.com.mx", :subject => "Contacto")
  end
end
