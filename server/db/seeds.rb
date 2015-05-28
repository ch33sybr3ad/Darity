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

'a', 'b', 'c', 'd', 'e' = users

dare = Dare.new(
  title: Faker::Lorem.sentence,
  description: Faker::Lorem.paragraph,
)

a.proposed_dares << dare
b.challenged_dares << dare
dare.pledgers << c
dare.pledgers << d
dare.pledgers << e

p dare.proposer == a
p dare.daree == b
p c.pledged_dares == dare
p d.pledged_dares == dare
p e.pledged_dares == dare
