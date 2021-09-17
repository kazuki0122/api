class Payment < ApplicationRecord
  belongs_to :results
  with_options presence: true do
    validates :payed
    validates :amount
  end
end
