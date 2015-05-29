class DaresController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @challenged_dares = @user.challenged_dares
    @proposed_dares = @user.proposed_dares
  end

  def show
    @dare = Dare.find(params[:id])
    @proposer = @dare.proposer
    @daree = @dare.daree
  end

  def new
    @user = User.find(params[:user_id])
    @dare = Dare.new
  end

  def create
    @dare = Dare.new(dare_params)
    @dare.proposer_id = params[:user_id]
    if @dare.save
      @daree = @dare.daree
      redirect_to @daree
    else
      render html: "<h1>ERROR</h1>"
    end
  end

  def edit
    @dare = Dare.find(params[:id])
  end

  def update
    @dare = Dare.find(params[:id])
    @dare.update(dare_params)
    redirect_to [@dare.proposer, @dare]
  end

  def set_price
    @dare = Dare.find(params[:id])
    @daree = @dare.daree
  end

  def put_price
    @dare = Dare.find(params[:id])
    @charity = Charity.find_or_create_by(name: dare_params[:charity])
    @dare.update(price: dare_params[:price], charity: @charity)
    redirect_to [@dare.proposer, @dare]
  end

  def destroy
    @dare = Dare.find(params[:id])
    @dare.destroy
    redirect_to current_user
  end

  private

  def dare_params
    params.require(:dare).permit(:price, :charity, :title, :description, :daree_id)
  end


end
