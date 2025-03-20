class RenameRegistrationConfirmationSentAt < ActiveRecord::Migration[8.0]
  def change
    rename_column :registrations, :registration_confirmation_sent_at, :registration_confirmation_notification_sent_at
  end
end
