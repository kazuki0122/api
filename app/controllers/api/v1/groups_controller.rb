class Api::V1::GroupsController < ApplicationController
  def index
    pending_users = GroupUser.where(status: 'pending', user_id: current_api_v1_user)
    # invite_groups = pending_users.map{|user| user.group}
    invite_groups = []
    pending_users.map do |user| 
      hash = user.group.attributes 
      hash[:create_user] = User.find(user.group.creater_id).name
      invite_groups.push(hash)
    end
    
    accepted_users = GroupUser.where(status: 'accepted', user_id: current_api_v1_user)
    join_groups = accepted_users.map{|user| user.group}
    render json: {
      status: 'success',
      pending_users: pending_users, 
      invite_groups: invite_groups,
      accepted_users: accepted_users,
      join_groups: join_groups,
    }

  end

  def create
    group = Group.new(group_params)
    if group.save!
      group.users << current_api_v1_user
      group.group_users.find_by(group_id: group.id, user_id: current_api_v1_user.id).update(status: 'accepted')
      render json: { status: 'success', data: group }
    else
      render json: { status: 'error', error: group.errors.messages }
    end
  end

  def show
    group = Group.find(params[:id])
    users = group.users
    render json: {status: 'success', data: users }
  end

  def enter_group
    current_user = current_api_v1_user
    data = Group.enter_group(current_user)
    render  json: {status: 'success', data: data }
  end
  
  def refused_to_enter
    current_user = current_api_v1_user
    data = Group.refused_to_enter(current_user)
    render json: {status: 'success', data: data }
  end

  def group_params
    params.require(:group).permit(:name, user_ids: []).merge(creater_id: current_api_v1_user.id)
  end

end
