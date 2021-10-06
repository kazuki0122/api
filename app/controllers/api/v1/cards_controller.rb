class Api::V1::CardsController < ApplicationController
  def index
  end

  def create
    card = Card.find_by(user_id: current_api_v1_user).update(payment_method_id: params[:payment_method])
    render json: {status: 'success', data: card}
  end
  
  def customer_create
    data = Card.customer_create
    # payment_method =  Stripe::PaymentMethod.list({
    #   customer: data['customer'],
    #   type: 'card',
    # })
    card = Card.new(customer_id: data['customer'],user_id: current_api_v1_user.id)
    card.save
    render json: {status: 'success', data: data }
  end
end
