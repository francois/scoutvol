class Event < ApplicationRecord
  include Slugify

  belongs_to :season
  has_many :registrations
  has_many :attendances

  validates :title, presence: true, length: {in: 1..200}
  validates :max_registrations, presence: true, inclusion: {in: 0..200}

  def self.ransackable_attributes(auth_object = nil)
    %w[title slug id]
  end

  def self.ransackable_associations(*)
    []
  end

  def full? = num_free_registrations.zero?

  def available? = !full?

  def num_free_registrations = max_registrations - registrations.size

  def record_registration!(person_name:, registration_email:, branch:)
    result = registrations.create!(person_name:, registration_email:, branch:)
    raise MaxRegistrationsExceeded if registrations.reload.size > max_registrations

    result
  end

  def record_attendance!(registration_slug, now: Time.current)
    registration = registrations.find_by!(slug: registration_slug)
    attendances.create!(
      person_name: registration.person_name,
      branch: registration.branch,
      attended_at: now
    )
  end

  def flip_attendance!(attendance_slug, now: Time.current)
    attendance = attendances.find_by!(slug: attendance_slug)
    attendance.update!(attended_at: attendance.attended? ? nil : now)
    attendance
  end

  def record_new_attendance!(person_name:, branch:, now: Time.current)
    attendances.create!(person_name:, branch:, attended_at: now)
  end

  def registered_count = registrations.count
  def attended_count = attendances.count
end
