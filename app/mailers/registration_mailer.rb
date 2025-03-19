class RegistrationMailer < ApplicationMailer
  def registration_confirmation
    @registrations = params[:registrations]

    # Safely send notifications: if notification was already sent, don't send it again
    @registrations = Registration.flag_all_as_registration_confirmation_notification_sent!(@registrations)
    return if @registrations.empty?

    mail to: @registrations.first.registration_email,
      subject: "Confirmation d'inscription"
  end

  def event_coming_up
    @registrations = params[:registrations]
    @event = @registrations.first.event

    # Safely send notifications: if notification was already sent, don't send it again
    @registrations = Registration.flag_all_as_event_coming_up_notification_sent!(@registrations)
    return if @registrations.empty?

    mail to: @registrations.first.registration_email,
      subject: "Rappel: #{@event.title} ce #{localize(@event.start_at, format: :day_name)} à #{localize(@event.start_at, format: :hour_minute)}"
  end
end
