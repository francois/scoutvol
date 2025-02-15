class Registration::Form
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email
  attribute :people

  validates :email, format: /\A.+@.+[.][a-z]+\z/
end
