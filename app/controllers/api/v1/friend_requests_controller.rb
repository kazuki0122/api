class Api::V1::FriendRequestsController < ApplicationController
  def index
    # 申請するユーザーのidを取得
    request_users = FriendRequest.where(from_id: current_api_v1_user.id)
    to_ids = request_users.map{|user| user.to_id}.uniq

    # 申請したユーザーのidを取得
    approval_users = FriendRequest.where(to_id: current_api_v1_user.id)
    from_ids = approval_users.map{|user| user.from_id}.uniq
    from_users =  from_ids.map {|id| from_users_record = User.find(id) }
    render json: {status: 'success', request: to_ids, approval: from_ids, users: from_users}
  end

  def create
    friend_request = FriendRequest.new(friend_request_params)
    if friend_request.save
      request_users =  FriendRequest.where(from_id: current_api_v1_user.id)
      # uniqは重複を避ける
      to_ids = request_users.map{|user| user.to_id}.uniq
      # unito_ids = to_ids.uniq
      render json: { status: 'success', data: friend_request, request: to_ids }
    else
      render json: {status: 'error', data: friend_request, error: friend_request.errors.messages}
    end
  end

  def friend_request_params
    params.require(:friend_request).permit(:from_id, :to_id)
  end
end
