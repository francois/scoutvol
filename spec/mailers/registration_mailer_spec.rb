require "rails_helper"

RSpec.describe RegistrationMailer, type: :mailer do
  describe "registration_confirmation" do
    let(:mail) { RegistrationMailer.registration_confirmation }

    it "renders the headers" do
      expect(mail.subject).to eq("Registration confirmation")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "event_coming_up" do
    let(:mail) { RegistrationMailer.event_coming_up }

    it "renders the headers" do
      expect(mail.subject).to eq("Event coming up")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
end
