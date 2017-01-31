desc 'Send Email if YPT is near expiration'
task :send_ypt_near_expiration_email => :environment do
  require 'date'
  if Date.today.day == 15 # only send on 15th of the month
    @adult = Adult.all
    @adult.each do |adult|
      next unless adult.inactive?
      next if adult.days_remaining_ypt =~ /Days Ago/
      days_remaining = adult.days_remaining_ypt.to_i
      if days_remaining.between? 1, 30
        YptExpirationMailer.ypt_expired_email(adult).deliver_later unless adult.email.blank?
      end
    end
  end
end