class SendEventReminderJob < ApplicationJob
  def perform
    cutoff_at = Time.now.in_time_zone("America/Montreal").change(hour: 5)
    events = Event.includes(:registrations).where(start_at: cutoff_at...1.day.after(cutoff_at)).to_a
    log_events_to_send_reminders_for(events, cutoff_at)
    events.each do |event|
      registrations_by_email = event.registrations
        .missing_event_coming_up_notification
        .group_by(&:registration_email)
      log_sending_reminder_emails(event, registrations_by_email)

      registrations_by_email.each do |email, registrations|
        RegistrationMailer.with(registrations:).event_coming_up.deliver_later
      end
    end
  end

  private

  def log_events_to_send_reminders_for(events, cutoff_at)
    logger.info do
      {
        class: self.class.name,
        message: "Events to send reminders for",
        events_count: events.size,
        cutoff_at:
      }.to_json
    end
  end

  def log_sending_reminder_emails(event, registrations_by_email)
    logger.info do
      {
        class: self.class.name,
        message: "Sending reminder emails",
        registration_emails: registrations_by_email.size,
        event: {
          id: event.id,
          title: event.title,
          start_at: event.start_at
        }
      }.to_json
    end
  end
end
