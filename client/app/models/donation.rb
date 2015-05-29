class Donation < ActiveRecord::Base
  belongs_to :user, foreign_key: "pledger_id"
  belongs_to :dare, foreign_key: "pledged_dare_id"

  attr_accessor :stripe_card_token

  def save_with_payment
    if valid?
        customer = Stripe::Customer.create(plan: pledger_id )
    end
  end
end
