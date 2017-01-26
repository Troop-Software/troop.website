class YptExpirationMailer < ApplicationMailer

  def ypt_expired_email(adult)
    @adult = adult
    mail to: 'bob@bobkoertge.com'
  end
end
