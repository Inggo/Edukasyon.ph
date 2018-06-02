class Rating < ApplicationRecord
  # Require rating and require it to be a number from 1-5
  validates :rating, presence: true, inclusion: { in: [1,2,3,4,5],
    message: "cannot be %{value}" }
  
  # Require email and validate format
  validates :email, presence: true, email: true

  # Define associations with other models
  belongs_to :course
  belongs_to :professor

  # Email should be lowercase
  before_save :downcase_email

  def downcase_email
    self.email.downcase!
  end
end
