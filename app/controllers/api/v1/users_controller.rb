module Api
  module V1
    class UsersController < ApplicationController
      include Pagination
      def index
        all_users = User.where.not(id: current_api_v1_user.id)
        from_records = Friend.where(from_id: current_api_v1_user)
        from_friends = from_records.map{ |friend| friend.to }.uniq
        to_records = Friend.where(to_id: current_api_v1_user)
        to_friends = to_records.map{ |friend| friend.from }.uniq
        current_friend = from_friends + to_friends
        not_friends = all_users - current_friend
        # 配列クラスにkaminariのメソッドを使用
        users = Kaminari.paginate_array(not_friends).page(params[:page]).per(3)
        pagination = resources_with_pagination(users)
        render json: {status: 'success', data: users, pages: pagination}
      end
    end
  end
end

