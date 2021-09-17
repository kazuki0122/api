class Result < ApplicationRecord 
  belongs_to :user
  belongs_to :rule
  validates :result, presence: true
end
