class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :group_requests
  has_many :froms, through: :group_requests, :source => :users
  has_many :tos, through: :group_requests, :source => :uesrs
  has_many :messages
  validates :name, presence: true, uniqueness: true
end
