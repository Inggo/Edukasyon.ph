class Rating < ApplicationRecord
  validates :rating, presence: true, inclusion: { in: [1,2,3,4,5],
    message: "cannot be %{value}" }
  validates :email, presence: true, email: true

  belongs_to :course
  belongs_to :professor
end
