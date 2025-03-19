class Registration < ApplicationRecord
  include Slugify

  scope :missing_event_coming_up_notification, -> { where(event_coming_up_notification_sent_at: nil) }

  belongs_to :event
  has_one :attendance, dependent: :destroy, primary_key: %i[event_id person_name], foreign_key: %i[event_id person_name]

  before_validation :normalize_registration_email

  validates :person_name, presence: true, length: {in: 1..200}
  validates :registration_email, format: /\A.+@.+[.][a-z]+\z/

  delegate :attended?, to: :attendance, allow_nil: true

  def self.ransackable_attributes(auth_object = nil)
    %w[person_name registration_email id]
  end

  def self.ransackable_associations(*)
    []
  end

  # @return [Array[Registration]] Registrations for which the notification has not yet been sent
  def self.flag_all_as_registration_confirmation_notification_sent!(registrations, now: Time.current)
    where(id: registrations, registration_confirmation_notification_sent_at: nil)
      .update_all(registration_confirmation_notification_sent_at: now)
    registrations.select { _1.registration_confirmation_notification_sent_at.nil? }
  end

  # @return [Array[Registration]] Registrations for which the notification has not yet been sent
  def self.flag_all_as_event_coming_up_notification_sent!(registrations, now: Time.current)
    where(id: registrations, event_coming_up_notification_sent_at: nil)
      .update_all(event_coming_up_notification_sent_at: now)
    registrations.select { _1.event_coming_up_notification_sent_at.nil? }
  end

  def branch_name = BRANCH_NAMES.invert.fetch(branch)

  def branch_order
    case branch
    when "castors" then 1
    when "chouettes" then 2
    when "aigles" then 3
    when "éclaireurs" then 4
    when "pionniers" then 5
    when "routiers" then 6
    when "gestion" then 7
    else
      raise ArgumentError, "Unrecognized branch: #{branch.inspect}"
    end
  end

  private

  def normalize_registration_email
    self.registration_email = registration_email.to_s.strip.downcase
  end
end
