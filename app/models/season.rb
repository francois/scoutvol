class Season < ApplicationRecord
  include Slugify

  has_many :events
  validates :name, presence: true, length: {in: 1..200}

  def self.ransackable_attributes(auth_object = nil)
    %w[name slug id]
  end

  def self.ransackable_associations(*)
    []
  end

  def add_events(title:, start_at:, end_at:, max_registrations:, shift_duration: 2.hours)
    self.class.transaction do
      while start_at < end_at
        events.create!(
          title:,
          start_at:,
          max_registrations:
        )

        start_at += shift_duration
      end
    end
  end
end
