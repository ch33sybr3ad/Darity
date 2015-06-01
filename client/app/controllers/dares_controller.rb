class DaresController < ApplicationController

  before_action(:find_dare, except: [:index, :new, :create])
  before_action(:find_user, only: [:index, :new])

  def index
    @challenged_dares = @user.challenged_dares
    @proposed_dares = @user.proposed_dares
  end

  def show
    @proposer = @dare.proposer
    @daree = @dare.daree
    @pledged = 0
    @dare.donations.each do |user|
      @pledged += user.donation_amount
    end
    @video = Video.where(dare_id: @dare.id).first
    p @url = @video.url.gsub(/&.*/, "").gsub(/.*=/, "")
  end

  def new
    @generate_dares = GenerateDare.all
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
  end

  def update
    @dare.update(dare_params)
    redirect_to [@dare.proposer, @dare]
  end

  def set_price
    @daree = @dare.daree
    @proposer = @dare.proposer
    @charities = Charity.all
  end

  def put_price
    @charity = Charity.find_or_create_by(name: dare_params[:charity])
    @dare.update(price: dare_params[:price], charity: @charity)
    redirect_to [@dare.proposer, @dare]
  end

  def destroy
    @dare.destroy
    redirect_to current_user
  end

  private

  def dare_params
    params.require(:dare).permit(:price, :charity, :title, :description, :daree_id)
  end

  def find_dare
    begin
    @dare = Dare.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render html: "<h1>Dare Action</h1>"
    end
  end

  def find_user
    begin
      @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
      render html: "<h1>User not found.</h1>"
    end
  end


end
