 class DonationsController < ApplicationController
  before_action(:find_dare, only: [:new, :paid])

  def new
    @user = User.where()
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
    @donation = Donation.find(params[:id])
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

    if @user.email == nil && @donation.save && @user.save && @dare.save
      @user.email = customer.email
      @user.save
      UserMailer.thank_you(@user, charge.amount.to_i/100, @dare.title, @dare.description, @dare.daree.username).deliver_later
      redirect_to @user
    else
      @donation.save && @user.save && @dare.save
      UserMailer.thank_you(@user, charge.amount.to_i/100, @dare.title, @dare.description, @dare.daree.username).deliver_later
      redirect_to @user
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to donations_path
  end

  def guage

  end

  private

    def donation_params
      params.require(:donation).permit(:donation_amount)
    end

    def find_dare
      begin
        @dare = Dare.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        @dare = Dare.new
        _404
      end
    end
end
