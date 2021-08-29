class Api::V1::UsersController < ApplicationController
  def index
    user = User.all
    render json: {status: 'success', data: user}
  end
end
