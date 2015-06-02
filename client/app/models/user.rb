class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token

  has_many :donations, foreign_key: "pledger_id"
  has_many :pledged_dares, through: :donations, source: :dare, foreign_key: "pledged_dare_id"

  has_many :challenged_dares, foreign_key: :daree_id, class_name: "Dare"
  has_many :proposed_dares, foreign_key: :proposer_id, class_name: "Dare"
  has_many :pending_dares, foreign_key: :proposer_id, class_name: "Dare"

  has_many :followers, through: :i_am_followee_relations
  has_many :i_am_followee_relations, class_name: "Relationship", foreign_key: "followee_id"

  has_many :followees, through: :i_am_follower_relations
  has_many :i_am_follower_relations, class_name: "Relationship", foreign_key: "follower_id"

  has_many :likes
  has_many :comments, through: :likes

  validates_uniqueness_of :username, :email
  validates :password, 
    presence: true,
    length: {:within => 6..40}

  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/


  has_secure_password

  before_create :create_activation_digest

  def all_dares
    challenged_dares + proposed_dares + pledged_dares
    # query = "select dares.* from dares join donations on dares.id = donations.pledged_dare_id where dares.proposer_id = #{id} or dares.daree_id = #{id} or donations.pledger_id = #{id}"
    # p ActiveRecord::Base.connection.execute(query).first
  end

  def challenged_feed
    challenged_dares.order(created_at: :desc)
  end

  def proposed_feed
    proposed_dares.order(created_at: :desc)
  end

  def pledged_feed
    pledged_dares.order(created_at: :desc)
  end

  def self.create_with_omniauth(auth)
    new_user = create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth['info']['nickname']
      user.image_url = auth['info']['image']
    end
    new_user.check_for_pending_dares
    new_user
  end

  def check_for_pending_dares
    dares = PendingDare.where(twitter_handle: username)
    if dares.any?
      dares.each do |pending|
        dare = Dare.create(
          title: pending.title,
          description: pending.description,
          proposer_id: pending.proposer_id,
          daree_id: id
        )
        pending.destroy
      end
    end
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Activates an account.
  def activate
    self.update_attribute(:activated,    true)
    self.update_attribute(:activated_at, Time.zone.now)
  end

  def send_welcome_email
      UserMailer.welcome_email(self).deliver_later
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
