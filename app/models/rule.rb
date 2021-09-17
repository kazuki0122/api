class Rule < ApplicationRecord
  belongs_to :group
  with_options presence: true do
    validates :charge
    validates :wakeup_time
  end
end
