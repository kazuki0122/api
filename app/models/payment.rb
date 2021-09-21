class Payment < ApplicationRecord
  has_one :result
  with_options presence: true do
    validates :amount
  end
  validates :payed, inclusion: { in: [true, false] }
end
