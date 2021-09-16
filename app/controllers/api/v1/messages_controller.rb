class Api::V1::MessagesController < ApplicationController
  def index
    users_messages = Message.all.order(:created_at)
    all_users_messages = []
     users_messages.map do |message|
      hash_message = message.attributes
      user = User.find(message.user_id)
      hash_message[:user_name] = user.attributes['name']
      hash_message['created_at'] = message.created_at.strftime("%m月%d日%H時%M分%S秒")
      all_users_messages.push(hash_message)
    end

    render json: {status: 'success', all_users: all_users_messages }
  end

  def create
    message = Message.new(message_params)
    if message.save
      hash_message = message.attributes
      hash_message['created_at'] = message.created_at.strftime("%m月%d日%H時%M分%S秒")
      render json: {status: 'success', data: hash_message}
    else
      render json: { status: 'error', error: message.errors.messages } 
    end
  end

  def message_params
    params.require(:message).permit(:content, :group_id).merge(user_id: current_api_v1_user.id)
  end
end
