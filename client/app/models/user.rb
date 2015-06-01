class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token

  has_many :donations, foreign_key: "pledger_id"
  has_many :pledged_dares, through: :donations, source: :dare, foreign_key: "pledged_dare_id"

  has_many :challenged_dares, foreign_key: :daree_id, class_name: "Dare"
  has_many :proposed_dares, foreign_key: :proposer_id, class_name: "Dare"
  has_many :pending_dares, foreign_key: :proposer_id, class_name: "Dare"

  before_create :create_activation_digest
  before_save :downcase_email

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

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
