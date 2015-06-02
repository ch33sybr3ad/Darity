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
    @pledged = @dare.donations.inject(0) { |sum, donation| sum + donation.donation_amount }
    @video = Video.where(dare_id: @dare.id).first
    @url = @video.url.gsub(/&.*/, "").gsub(/.*=/, "") if @video
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
  end

  def update
    _404 if @dare.proposer != current_user
    @dare.update(dare_params)
    redirect_to [@dare.proposer, @dare]
  end

  def set_price
    @daree = @dare.daree
    _404 if @daree != current_user
    @proposer = @dare.proposer
    @charities = Charity.all
  end

  def put_price
    _404 if @dare.daree != current_user
    @charity = Charity.find_or_create_by(name: dare_params[:charity])
    @dare.update(price: dare_params[:price], charity: @charity)
    redirect_to [@dare.proposer, @dare]
  end

  def destroy
    @dare.destroy if current_user == @dare.daree || current_user == @dare.proposer
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
      @dare = Dare.new
      _404
    end
  end

end
