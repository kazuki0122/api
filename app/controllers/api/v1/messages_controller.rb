class Api::V1::MessagesController < ApplicationController
  def index
  end

  def create
    message = Message.new(message_params)
    if message.save
      render json: {status: 'success', data: message}
    else
      render json: { status: 'error', error: message.errors.messages } 
    end
  end

  def message_params
    params.require(:message).permit(:content, :group_id).merge(user_id: current_api_v1_user.id)
  end
end
