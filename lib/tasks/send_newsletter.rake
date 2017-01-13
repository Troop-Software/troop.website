desc 'Send Weekly Newsletter'
task :send_newsletter => :environment do
  require 'date'
  if Date.today.wday == 5  # only send on Fridays
    @users = User.all
    @users.each do |user|
      NewsletterMailer.weekly_email(user).deliver_later
    end
  end
end