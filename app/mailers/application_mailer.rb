class ApplicationMailer < ActionMailer::Base
  email_address = ENV['EMAIL_FROM_ADDRESS'] || 'test@example.com'
  default from: email_address
  layout 'mailer'
end
