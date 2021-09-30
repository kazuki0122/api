class Card < ApplicationRecord
  belongs_to :user
  
  def self.customer_create
    customer = Stripe::Customer.create
    return data = Stripe::SetupIntent.create(customer: customer['id'])
  end
end