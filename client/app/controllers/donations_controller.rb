 class DonationsController < ApplicationController

  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.create(pledger_id: session[:user_id], pledged_dare_id: params[:dare_id], donation_amount: donation_params['donation_amount'].to_i)
    redirect_to pay_donations_path(params[:dare_id], @donation.id)
  end

  def pay
    @donation = Donation.find(params[:id])
    @amount = @donation.donation_amount * 100
  end

  def paid
    @dare = Dare.find(params[:dare_id])
    @donation = Donation.find(params[:id])
    @user = User.find(@donation.pledger_id)

    customer = Stripe::Customer.create(
        :email => @user.email,
        :card  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => @user.id,
        :amount      => @donation.donation_amount * 100,
        :description => @dare.title,
        :currency    => 'usd'
      )
    @donation.completed = true
    @donation.save
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to donations_path
  end

  private

    def donation_params
      params.require(:donation).permit(:donation_amount)
    end
end
