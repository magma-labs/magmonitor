# frozen_string_literal: true

# Module shared by models that are accessed by slug rather than id
module Sluggable
  extend ActiveSupport::Concern

  included do
    before_validation :build_slug
    validates :name, presence: true, uniqueness: { case_sensitive: false }
  end

  # @return [String] this object's permalink
  def to_param
    slug
  end

  private

  def build_slug
    self.slug = name.parameterize
  end
end
