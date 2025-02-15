class Registration < ApplicationRecord
  include Slugify

  belongs_to :event
  validates :person_name, presence: true, length: {in: 1..200}
  validates :registration_email, format: /\A.+@.+[.][a-z]+\z/
end
