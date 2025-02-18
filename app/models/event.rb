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
end
