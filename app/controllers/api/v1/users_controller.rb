class Api::V1::UsersController < ApplicationController
  def index
    user = User.limit(params[:limit])
    render json: {status: 'success', data: user}
  end
end
