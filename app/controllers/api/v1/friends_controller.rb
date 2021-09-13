class Api::V1::FriendsController < ApplicationController
  def index
    from_records = Friend.where(from_id: current_api_v1_user)
    from_friends = from_records.map{ |friend| friend.to }.uniq
    to_records = Friend.where(to_id: current_api_v1_user)
    to_friends = to_records.map{ |friend| friend.from }.uniq
    friends = from_friends + to_friends
    render json: {status: 'success', data: friends }
  end

  def create
    friend = Friend.new(friend_params)
    if friend.save
      FriendRequest.find_by(from_id: friend.from_id, to_id: friend.to_id ).destroy
      render json: { status: 'success', data: friend }
    else
      render json: {status: 'error', data: friend, error: friend.errors.messages}
    end
  end

  def friend_params
    params.require(:friend).permit(:from_id, :to_id)
  end
end
