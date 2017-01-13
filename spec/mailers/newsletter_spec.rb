require "rails_helper"

RSpec.describe NewsletterMailer, type: :mailer do
  describe "weekly_email" do
    let(:mail) { NewsletterMailer.weekly_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Weekly email")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
