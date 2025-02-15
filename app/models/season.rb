class Season < ApplicationRecord
  include Slugify

  has_many :events
  validates :name, presence: true, length: {in: 1..200}
end
