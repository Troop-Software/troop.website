class YptExpirationMailer < ApplicationMailer

  def ypt_expired_email(adult)
    @adult = adult
    mail to: @adult.email
  end
end
