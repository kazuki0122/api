class Rule < ApplicationRecord
  belongs_to :group
  with_options presence: true do
    validates :wakeup_time
    validates :charge, numericality:{greater_than_or_equal_to: 100, less_than_or_equal_to: 2000, message: 'の指定範囲が不正です'}
  end
end
