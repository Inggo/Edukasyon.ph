class Course < ApplicationRecord
  validates :name, presence: true
  has_and_belongs_to_many :professors
  
  has_many :ratings
end
