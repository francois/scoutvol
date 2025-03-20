RSpec.describe SendEventReminderJob do
  describe "#perform" do
    it "sends event coming up emails to registered people for events between 24h and 48h from now" do
      expect {
        SendEventReminderJob.new.perform
      }.to have_enqueued_job(ActionMailer::MailDeliveryJob).with(
        RegistrationMailer.name,
        "event_coming_up",
        "deliver_now",
        params: {
          registrations: [registrations(:paul)]
        },
        args: []
      )
    end
  end
end
