class Api::V1::CardsController < ApplicationController
  def index
  end

  def create
  end
  
  def customer_create
    data = Card.customer_create
    render json: {status: 'success', data: data }
  end
end
