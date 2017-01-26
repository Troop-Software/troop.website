desc 'Send Email if YPT Expired'
task :send_ypt_expired_email => :environment do
  require 'date'
  if Date.today.day == 15 # only send on 15th of the month
    @adult = Adult.ypt_expired
    @adult.each do |adult|
      unless adult.email.blank?
        YptExpirationMailer.ypt_expired_email(adult).deliver_later
      end
    end
  end
end