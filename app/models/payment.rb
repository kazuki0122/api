class Payment < ApplicationRecord
  has_one :result
  validates :amount, presence:true
end
