class YptNearingExpirationMailer < ApplicationMailer

  def ypt_nearing_expiration(adult)
    @adult = adult
    #mail to: @adult.email
    mail to: 'bob@bobkoertge.com'
  end
end
