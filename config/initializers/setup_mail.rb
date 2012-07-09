ActionMailer::Base.smtp_settings = {
  :user_name => "erikescobedo",
  :password => "3r1k0mail",
  :domain => "1808.com.mx",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
