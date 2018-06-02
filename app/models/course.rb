class Course < ApplicationRecord
  # Require name for Courses
  validates :name, presence: true

  # Define associations with other models
  has_and_belongs_to_many :professors
  has_many :ratings
end
