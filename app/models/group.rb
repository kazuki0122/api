class Group < ApplicationRecord
  # グループ作成
  has_many :group_users
  has_many :users, through: :group_users
  belongs_to :creater, class_name: 'User'
  has_many :messages
  validates :name, presence: true, uniqueness: true
  has_many :rules

  def self.enter_group(current_user)
    GroupUser.find_by(user_id: current_user).update(status: "accepted")
  end

  def self.refused_to_enter(current_user)
    GroupUser.find_by(user_id: current_user).delete
  end
end
 