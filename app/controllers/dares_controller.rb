class DaresController < ApplicationController
  before_action :check_logged_in!, except: :show
  before_action :find_dare, except: [:new, :create]
  before_action :find_user, only: [:new]

  def show
    @proposer = @dare.proposer
    @daree = @dare.daree
    @pledgers = @dare.pledgers
    
    @pledged = @dare.pledged
    @charity = @dare.charity

    @video = Video.where(dare_id: @dare.id).first
    @comment = Comment.new
    @comments = @dare.comments
  end

  def new
    @dare = Dare.new
  end

  def create
    @dare = Dare.new(dare_params)
    @dare.proposer_id = params[:user_id]
    if @dare.save
      @daree = @dare.daree
      redirect_to @daree
    else
      flash[:error] = "Invalid Dare"
      render :new
    end
  end

  def edit
    authorized_user!(@dare.proposer)
    @user = current_user
    @daree = @dare.daree
  end

  def update
    authorized_user!(@dare.proposer)
    @dare.update(dare_params)
    redirect_to [@dare.proposer, @dare]
  end

  def set_price
    @daree = @dare.daree
    authorized_user!(@daree)
    @proposer = @dare.proposer
    @charities = Charity.all
  end

  def put_price
    authorized_user!(@dare.daree)
    @charity = Charity.where(name: dare_params[:charity]).first || Charity.first
    @dare.update_attributes(price: dare_params[:price], charity: @charity)
    redirect_to [@dare.proposer, @dare]
  end

  def destroy
    @dare.destroy if current_user == @dare.daree || current_user == @dare.proposer
    redirect_to current_user
  end

  def approve
    @donation = @donations.where(pledger_id: current_user.id).first
    @donation.update_attributes(approve: 1) if @donation
    render json: @dare
  end

  def disapprove
    @donation = @donations.where(pledger_id: current_user.id).first
    @donation.update_attributes(approve: 0) if @donation
    render json: @dare
  end

  private

    def dare_params
      params.require(:dare).permit(:price, :charity, :title, :description, :daree_id)
    end

    def authorized_user!(user)
      error_page(401) if user != current_user
    end

end
