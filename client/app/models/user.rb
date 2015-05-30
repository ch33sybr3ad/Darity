class User < ActiveRecord::Base
  has_many :donations, foreign_key: "pledger_id"
  has_many :pledged_dares, through: :donations, source: :dare, foreign_key: "pledged_dare_id"

  has_many :challenged_dares, foreign_key: :daree_id, class_name: "Dare"
  has_many :proposed_dares, foreign_key: :proposer_id, class_name: "Dare"
  has_many :pending_dares, foreign_key: :proposer_id, class_name: "Dare"


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

end
