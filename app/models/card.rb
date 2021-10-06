class Card < ApplicationRecord
  belongs_to :user
  
  def self.customer_create
    customer = Stripe::Customer.create
    Stripe::SetupIntent.create(customer: customer['id'])
  end
end