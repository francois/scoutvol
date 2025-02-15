class Event < ApplicationRecord
  include Slugify

  belongs_to :season
  has_many :registrations
  has_many :attendances

  validates :title, presence: true, length: {in: 1..200}
  validates :max_registrations, presence: true, inclusion: {in: 0..200}

  def record_registration!(person_name:, registration_email:, branch:)
    self.class.transaction(requires_new: true) do
      registrations.create!(person_name:, registration_email:, branch:)
      raise MaxRegistrationsExceeded if registrations.reload.size > max_registrations
    end
  end
end
