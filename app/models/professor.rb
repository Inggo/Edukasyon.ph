class Professor < ApplicationRecord
  # Require name for Professors
  validates :name, presence: true

  # Define associations with other models
  has_and_belongs_to_many :courses
  has_many :ratings
end
