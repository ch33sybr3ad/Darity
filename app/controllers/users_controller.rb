class UsersController < ApplicationController
  before_action :check_logged_in!, only: [:update, :feed, :edit]
  before_action :find_user, only: [:show, :edit, :update]

  def show
    @relationship = Relationship.where(followee_id: params[:id], follower_id: current_user.id) if current_user
    @followees = @user.followees
    @sample_dare = Dare.first
    case params[:dare_type]
    when 'challenged'
      @challenged_dares = @user.challenged_dares
      render :'dares/challenged', layout: false
    when 'proposed'
      @proposed_dares = @user.proposed_dares
      render :'dares/proposed', layout: false
    when 'pledged'
      @pledged_dares = @user.pledged_dares
      render :'dares/pledged', layout: false
    end
  end

  def home
    @user = User.new
  end

  def about
  end

  def index
    @pending_dare = PendingDare.new
    if params[:phrase]
      @users = User.where("username LIKE ?", "%#{params[:phrase]}%")
      render json: @users.to_json, only: [:username, :image_url, :id]
    else
      @users = User.paginate(page: params[:page], :per_page => 30)
    end
  end

  def edit
  end

  def update
    if !@user.password_digest || @user.authenticate(user_params['current_password'])
      if user_params['new_password'] != ''
        if user_params['new_password'] == user_params['confirm_password']
          @user.password = user_params['new_password']
          flash[:notice] = "Password Changed" if @user.save
        else
          @user.errors.add(:new_password, "doesn't match")
        end
      end
      if @user.errors.empty? && @user.update(email: user_params['email'])
        flash[:notice] = "Email Changed"
      end
    else
      @user.errors.add(:current_password, "incorrect")
    end
    render "edit", id: @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(signup_params)
    if already_a_twitter_handle?(@user.username)
      @user.errors.add(:username, 'is already taken')
    end
    respond_to do |format|
      if @user.errors.empty? && @user.save
        Dare.create(
          title: GenerateDare.all.shuffle.first.description,
          description: "Welcome to Darirty. Welcome to Darity. Your first mission is to COMPLETE this dare.",
          daree_id: @user.id,
          proposer_id: 1
        )
        session[:user_id] = @user.id
        @user.send_welcome_email
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account"
        format.html { redirect_to @user, notice: 'Darity email sent. Please check your email to activate your account' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def feed
    @followee_ids = current_user.followees.pluck(:id)
    @dares = Dare.dares_involving(@followee_ids)
  end

  def new_invite
    @pending_dare = PendingDare.new
  end

  def check
    render (already_a_twitter_handle?(params[:handle]) ? { json: true } : { json: false })
  end

  private

    def signup_params
      params.require(:user).permit(:username, :email, :password)
    end

    def already_a_twitter_handle?(handle)
      reply = HTTParty.get("http://twitter.com/#{handle}").parsed_response
      !(reply =~ /Sorry, that page doesn/)
    end

end
