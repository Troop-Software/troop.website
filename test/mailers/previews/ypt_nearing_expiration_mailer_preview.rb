# Preview all emails at http://localhost:3000/rails/mailers/ypt_nearing_expiration_mailer
class YptNearingExpirationMailerPreview < ActionMailer::Preview

  def ypt_nearing_expiration
    YptNearingExpirationMailer.ypt_nearing_expiration(Adult.last)
  end
end
