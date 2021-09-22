class GroupRequest < ApplicationRecord
  belongs_to :group
  belongs_to :from, class_name: 'User'
  belongs_to :to, class_name: 'User'
end
