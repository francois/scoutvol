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
end
