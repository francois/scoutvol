class Registration < ApplicationRecord
  include Slugify

  belongs_to :event
  validates :person_name, presence: true, length: {in: 1..200}
  validates :registration_email, format: /\A.+@.+[.][a-z]+\z/

  def self.ransackable_attributes(auth_object = nil)
    %w[person_name registration_email id]
  end

  def self.ransackable_associations(*)
    []
  end

  def branch_name = BRANCH_NAMES.invert.fetch(branch)

  def branch_order
    case branch
    when "castors" then 1
    when "chouettes" then 2
    when "aigles" then 3
    when "éclaireurs" then 4
    when "pionniers" then 5
    when "routiers" then 6
    when "gestion" then 7
    else
      raise ArgumentError, "Unrecognized branch: #{branch.inspect}"
    end
  end
end
