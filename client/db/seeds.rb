require 'faker'

User.delete_all
Dare.delete_all

users = Array.new(5) do
  User.create!(
    username: Faker::Internet.user_name,
    password: Faker::Internet.password,
    email: Faker::Internet.safe_email,
    uid: Faker::Number.number(10),
    provider: 'Twitter'
  )
end

a, b, c, d, e = users

dare = Dare.new(
  title: Faker::Lorem.sentence,
  description: Faker::Lorem.paragraph,
)

charity = Charity.new(
  name: 'Ping Pong 4 Kids',
  url: 'http://pingpong.com',
  description: 'provides ping pong to poor and rich kids',
  picture_url: 'http://callsfreecalls.com/images/CFC_unique_charity.jpg'
)

a.proposed_dares << dare
b.challenged_dares << dare
dare.pledgers << c
dare.pledgers << d
dare.pledgers << e
charity.dares << dare

p dare.proposer == a
p dare.daree == b
p c.pledged_dares.first == dare
p d.pledged_dares.first == dare
p e.pledged_dares.first == dare
p dare.charity == charity
