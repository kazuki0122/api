class FriendRequest < ApplicationRecord
  belongs_to :from, class_name: 'User'
  belongs_to :to, class_name: 'User'

  def self.refusedRequest(from_id, current_user)
    FriendRequest.find_by(from_id: from_id, to_id: current_user).delete
  end

end
