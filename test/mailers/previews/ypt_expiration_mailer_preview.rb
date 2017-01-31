# Preview all emails at http://localhost:3000/rails/mailers/ypt_expiration_mailer
class YptExpirationMailerPreview < ActionMailer::Preview
  def ypt_expired_email
    YptExpirationMailer.ypt_expired_email(Adult.last)
  end
end
