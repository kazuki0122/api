class Payment
  def self.register_customer(card_token)
    customer = Stripe::Customer.create
    data = Stripe::SetupIntent.create(
      customer: customer['id']
    )
    data.to_json
  end
end