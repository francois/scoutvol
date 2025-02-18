class RegistrationMailer < ApplicationMailer
  def registration_confirmation
    @registrations = params[:registrations]

    mail to: @registrations.first.registration_email,
      subject: "Confirmation d'inscription"
  end

  def event_coming_up
    @registrations = params[:registrations]
    @event = @registrations.first.event

    mail to: @registrations.first.registration_email,
      subject: "Rappel: #{@event.title} ce #{localize(@event.start_at, format: :day_name)} à #{localize(@event.start_at, format: :hour_minute)}"
  end
end
