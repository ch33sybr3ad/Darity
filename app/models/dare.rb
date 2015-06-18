class Dare < ActiveRecord::Base
  has_many :donations, foreign_key: "pledged_dare_id"
  has_many :pledgers, through: :donations, source: :user
  has_one :video
  has_many :comments

  belongs_to :proposer, foreign_key: :proposer_id, class_name: "User"
  belongs_to :daree, foreign_key: :daree_id, class_name: "User"
  belongs_to :charity

  validates_presence_of :title, :description, :proposer_id, :daree_id
  validates :price, allow_nil: true, numericality: true
  # validates :approve,
  #           allow_nil: true,
  #           numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }

  def pledged
    donations.inject(0) { |sum, donation| sum + donation.donation_amount }
  end

  def approval_rate
    approvals = donations.where(approve: 1).count
    votes = donations.where("approve is not null").count
    return approvals/votes.to_f unless votes == 0
      0
  end

  def self.parse(args)
    Dare.new(
      id: args['id'],
      description: args['description'],
      title: args['title'],
      daree_id: args['daree_id'],
      proposer_id: args['proposer_id'],
      charity_id: args['charity_id'],
      done: args['done'] != 'f',
      price: args['price']
    )
  end

  def self.dares_involving(users_ids)
    return [] if users_ids.empty?
    query = 'SELECT dares.*,
            (
              SELECT username
              FROM users
              WHERE id = dares.daree_id
            ) AS daree_username,
            (
              SELECT username
              FROM users
              WHERE id = dares.proposer_id
            ) AS proposer_username,
            (
            SELECT SUM(donation_amount)
            FROM donations
            JOIN dares da
            ON donations.pledged_dare_id = da.id
            WHERE donations.pledged_dare_id = dares.id
            ) AS amount_raised
            FROM dares
            WHERE '
    users_ids.each do |id|
      query << "daree_id = #{id} OR proposer_id = #{id} OR "
    end
    query.sub!(/OR $/, 'ORDER BY created_at DESC;')
    ActiveRecord::Base.connection.execute(query)
  end

end

