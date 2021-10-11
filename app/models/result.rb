class Result < ApplicationRecord 
  belongs_to :user
  belongs_to :rule
  belongs_to :payment
  validates :result, inclusion: { in: [true, false] }
end