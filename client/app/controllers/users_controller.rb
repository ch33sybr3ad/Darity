class UsersController < ApplicationController
  before_action(:find_user, only: [:show, :edit, :update])

  def show
    @relationship = Relationship.where(followee_id: params[:id], follower_id: current_user.id) if current_user
    @followees = @user.followees
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
    else
      retreive_all_dares
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
      render json: @users
    else
      @users = User.all
    end
  end

  def login
    @user = User.where(email: user_params["email"]).first
    if @user && @user.password == user_params["password"]
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Signed In'
    else
      @user = User.new(email: user_params["email"])
      flash[:error] = 'Invalid Info'
      render :home
    end
  end

  def edit
  end

  def update
    if @user.password == user_params['current_password']
      if user_params['new_password'] && user_params['confirm_password']
        @user.update(password: user_params['new_password'])
      end
      if @user.update(email: user_params['email'])
        flash[:notice] = "Successfully Changed Account Settings"
        render "edit", id: @user
      else
        flash[:error] = "Invalid Email"
        render "edit", id: @user
      end
    else
      flash[:error] = "Incorrect Password"
      render "edit", id: @user
    end
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
        # Tell the UserMailer to send a welcome email after save
        session[:user_id] = @user.id
        @user.send_welcome_email
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account"
        format.html { redirect_to @user, notice: 'Darity email sent. Please check your email to activate your account' }
        format.json { render json: @user, status: :created, location: @user }
      else
        flash[:error] = @user.errors.full_messages.first
        format.html { redirect_to new_user_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def feed
    @followees = current_user.followees
    @all_dares = @followees.flat_map { |followee|
      followee.all_dares
    }
  end

  def new_invite
    @pending_dare = PendingDare.new
  end

  def invite
    @pending_dare = PendingDare.new(pend_params)
    @pending_dare.proposer = current_user
    if @pending_dare.save
      redirect_to @pending_dare
    else
      p 'fail'
    end
  end

  def check
    render (already_a_twitter_handle?(params[:handle]) ? { json: true } : { json: false })
  end

  private

  def retreive_all_dares
    @challenged_dares = @user.challenged_dares
    @proposed_dares = @user.proposed_dares
    @pledged_dares = @user.pledged_dares
  end

  def user_params
    params.require(:user).permit(:email, :password, :current_password, :new_password, :confirm_password)
  end

  def pend_params
    params.require(:pending_dare).permit(:title, :description, :twitter_handle)
  end

  def signup_params
    params.require(:user).permit(:username, :email, :password)
  end

  def already_a_twitter_handle?(handle)
    reply = HTTParty.get("http://twitter.com/#{handle}").parsed_response
    !(reply =~ /Sorry, that page doesn/)
  end

end
