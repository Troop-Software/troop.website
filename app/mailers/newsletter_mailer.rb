class NewsletterMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.newsletter_mailer.weekly_email.subject
  #
  def weekly_email(user)
    @events = Event.where('start > ?', Date.today).where('start < ?', Date.today.next_month)
    @articles = Article.where('created_at > ?', Date.today.last_week).where('created_at < ?', Date.today.next_month)

    mail to: user.email
  end
end
