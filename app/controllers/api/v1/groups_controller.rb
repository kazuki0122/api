class Api::V1::GroupsController < ApplicationController
  def index
    # group = Group.find(params[:id])
    # render json: {status: 'success', data: group }
  end

  def create
    group = Group.new(group_params)
      if group.save
        render json: { status: 'success', data: group }
      else
        render json: { status: 'error', data: group, error: group.errors.messages }
      end
  end

  def show
    group = Group.find(params[:id])
    users = group.users
    render json: {status: 'success', data: users }
  end

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end
