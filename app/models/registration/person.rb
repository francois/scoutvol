class Registration::Person
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name
  attribute :branch

  validates :name, presence: true, length: {in: 1..200}
  validates :branch, presence: true
end
