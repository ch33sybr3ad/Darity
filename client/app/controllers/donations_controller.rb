 class DonationsController < ApplicationController
  before_action(:find_dare, only: [:new, :paid])
  before_action(:find_donation, only: [:pay, :paid])

  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.create(pledger_id: session[:user_id], pledged_dare_id: params[:dare_id], donation_amount: donation_params['donation_amount'].to_i)
    redirect_to pay_donations_path(params[:dare_id], @donation.id)
  end

  def pay
    @amount = @donation.donation_amount * 100
  end

  def paid
    @user = User.find(@donation.pledger_id)

    customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :card  => params[:stripeToken]
      )
    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @donation.donation_amount * 100,
        :description => @dare.description,
        :currency    => 'usd'
      )
    @donation.completed = true

    if @user.email == nil && @donation.save && @dare.save
      @user.email = customer.email
      @user.save
    end
    UserMailer.thank_you(@user, charge.amount.to_i/100, @dare.title, @dare.description, @dare.daree.username).deliver_later
    redirect_to @user

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to donations_path
  end

  private

    def donation_params
      params.require(:donation).permit(:donation_amount)
    end

    def find_donation
      @donation = Donation.find(params[:id])
    end
    
end
