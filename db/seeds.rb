require 'faker'

users = Array.new(5) do
  User.create!(
    username: Faker::Internet.user_name,
    password: "123456",
    email: Faker::Internet.safe_email,
    uid: Faker::Number.number(10),
    provider: 'Twitter',
    admin: true,
    image_url: "https://robohash.org/#{Faker::Name.last_name}.png?size=50x50",
    activated: true,
    activated_at: Time.zone.now
  )
end

Dare.create!(
  title: 'Deliver a 3-5 minute lecture to your parents entitled "flirting for the modern teenager".',
  description: 'Be sure to include diagrams and demonstrations. Uses the other players to demonstrate your points.',
  proposer: users.first,
  daree: users[1]
)

Charity.create!(
  name: 'Darity Charity',
  url: 'teamdarity.herokuapp.com',
  mission: 'To harness the power of human generosity through dares.',
  transparency_score: 100,
)

File.open('./db/dares.csv').each do |line|
  GenerateDare.create!(description: "#{line.chomp}")
end

all_dares = GenerateDare.all

5.times do

  charity = Charity.order("RANDOM()").first

  users.rotate!

  a, b, c, d, e = users

  dare = Dare.new(
    title: all_dares.shuffle.first.description,
    description: Faker::Lorem.paragraph,
    price: 10
  )

  a.proposed_dares << dare
  b.challenged_dares << dare
  dare.donations.create!(user: c, donation_amount: 2)
  dare.donations.create!(user: d, donation_amount: 2)
  dare.donations.create!(user: e, donation_amount: 2)
  charity.dares << dare

  p dare.proposer == a
  p dare.daree == b
  p c.pledged_dares.last == dare
  p d.pledged_dares.last == dare
  p e.pledged_dares.last == dare
  p dare.charity == charity

dare.save

  Relationship.create!(
    follower: a,
    followee: b
  )
  Relationship.create!(
    follower: a,
    followee: c
  )
end

first_user = User.first
second_user = User.second
first_dare = Dare.first
first_dare.price = 10
first_dare.done = true
first_dare.save
second_dare = Dare.second
second_dare.price = 10
second_dare.save

PendingDare.create(title: all_dares.shuffle.first.description, description: "YOU AIN'T DOWN", proposer_id: first_user.id, twitter_handle: "acarl005")
PendingDare.create(title: all_dares.shuffle.first.description, description: "YOU AIN'T DOWN", proposer_id: first_user.id, twitter_handle: "CharlieDubs23" )
PendingDare.create(title: all_dares.shuffle.first.description, description: "YOU AIN'T DOWN", proposer_id: second_user.id, twitter_handle: "nomnomnaam")
PendingDare.create(title: all_dares.shuffle.first.description, description: "YOU AIN'T DOWN", proposer_id: second_user.id, twitter_handle: "ch33sybr3ad" )

Comment.create(body: Faker::Lorem.sentence, author_id: first_user.id, dare_id: first_dare.id)
Comment.create(body: Faker::Lorem.sentence, author_id: second_user.id, dare_id: first_dare.id)


Video.create(title: "testing", url: "https://www.youtube.com/watch?v=Y2bNfUNUpRk", dare_id: first_dare.id, description: "video is for testing", uid: "Y2bNfUNUpRk")
Video.create(title: "THIS IS...", url: "https://www.youtube.com/watch?v=Oqa9tKarkNA", dare_id: second_dare.id, description: "UNACCEPTABLE!!!", uid: "Oqa9tKarkNA")




