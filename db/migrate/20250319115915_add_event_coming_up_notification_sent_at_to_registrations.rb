class AddEventComingUpNotificationSentAtToRegistrations < ActiveRecord::Migration[8.0]
  def change
    change_table :registrations, bulk: true do |t|
      t.column :registration_confirmation_sent_at, :datetime
      t.column :event_coming_up_notification_sent_at, :datetime
    end
  end
end
