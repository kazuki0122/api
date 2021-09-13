# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :group_users
  has_many :groups, through: :group_users

  has_many :friend_requests
  has_many :friends


  # has_many :friend_requests, foreign_key: "to_id", class_name: 'FriendRequest'
  # has_many :friends, foreign_key: "from_id", class_name: 'Friend'

  validates :phone_number, presence: true
  validates :phone_number, numericality: {message: 'はハイフン無しにしてください'}
  validates :phone_number, length: { maximum: 11 , message: 'の値が不正です'}
end
