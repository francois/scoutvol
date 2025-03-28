class Attendance < ApplicationRecord
  include Slugify

  belongs_to :event
  validates :person_name, presence: true, length: {in: 1..200}

  def self.ransackable_attributes(auth_object = nil)
    %w[person_name id]
  end

  def self.ransackable_associations(*)
    []
  end

  def branch_name = BRANCH_NAMES.invert.fetch(branch)

  def attended? = attended_at.present?
end
