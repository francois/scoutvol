class SendEventReminderJob < ApplicationJob
  retry_on StandardError, attempts: 0

  def perform
    between = 1.day.from_now.change(hour: 5)...2.days.from_now.change(hour: 5)
    events = Event.coming_up(between:).to_a
    log_events_to_send_reminders_for(events, between)

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

  def log_events_to_send_reminders_for(events, start_at)
    logger.info do
      {
        class: self.class.name,
        message: "Events to send reminders for",
        events_count: events.size,
        start_at: [start_at.first.iso8601, start_at.end.iso8601]
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
