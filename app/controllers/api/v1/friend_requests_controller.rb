class Api::V1::FriendRequestsController < ApplicationController
  def index
    # 申請するユーザーのidを取得
    to_ids = FriendRequest.where(from_id: current_api_v1_user.id).map{|user| user.to_id}.uniq

    # 申請したユーザーのidを取得
    from_ids = FriendRequest.where(to_id: current_api_v1_user.id).map{|user| user.from_id}.uniq
    from_users =  from_ids.map {|id| from_users_record = User.find(id) }
    render json: {status: 'success', request: to_ids, approval: from_ids, users: from_users}
  end

  def create
    friend_request = FriendRequest.new(friend_request_params)
    if friend_request.save
      request_users =  FriendRequest.where(from_id: current_api_v1_user.id)
      to_ids = request_users.map{|user| user.to_id}.uniq
      render json: { status: 'success', data: friend_request, request: to_ids }
    else
      render json: {status: 'error', data: friend_request, error: friend_request.errors.messages}
    end
  end

  def refusedRequest
    current_user = current_api_v1_user
    from_id = params[:from_id]
    data = FriendRequest.refusedRequest(from_id, current_user)
    render json: {status: 'success', data: data}
  end

  def friend_request_params
    params.require(:friend_request).permit(:from_id, :to_id)
  end
end
