# Preview all emails at http://localhost:3000/rails/mailers/newsletter
class NewsletterPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/newsletter/weekly_email
  def weekly_email
    NewsletterMailer.weekly_email
  end

end
