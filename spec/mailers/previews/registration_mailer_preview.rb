# Preview all emails at http://localhost:3000/rails/mailers/registration_mailer
class RegistrationMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/registration_mailer/registration_confirmation_multi
  def registration_confirmation_multi
    registration_email = Registration.group(:registration_email).having("count(*) > 1").count.first.first
    registrations = Registration.where(registration_email:).to_a
    RegistrationMailer.with(registrations:).registration_confirmation
  end

  def registration_confirmation_single
    registration_email = Registration.group(:registration_email).having("count(*) = 1").count.first.first
    registrations = Registration.where(registration_email:).to_a
    RegistrationMailer.with(registrations:).registration_confirmation
  end

  def event_coming_up_multi
    registration_email = Registration.group(:registration_email).having("count(*) > 1").count.first.first
    registrations = Registration.where(registration_email:).to_a
    RegistrationMailer.with(registrations:).event_coming_up
  end

  def event_coming_up_single
    registration_email = Registration.group(:registration_email).having("count(*) = 1").count.first.first
    registrations = Registration.where(registration_email:).to_a
    RegistrationMailer.with(registrations:).event_coming_up
  end
end
