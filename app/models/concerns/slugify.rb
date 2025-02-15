module Slugify
  extend ActiveSupport::Concern

  included do
    before_validation :generate_unique_slug, on: :create
    validates :slug, presence: true, uniqueness: true, length: {is: 5}
  end

  def to_param = slug

  private

  def generate_unique_slug
    self.slug ||= generate_slug
  end

  def generate_slug
    loop do
      slug = SecureRandom.alphanumeric(5).downcase
      break slug unless self.class.exists?(slug: slug)
    end
  end
end
