require 'faker'

User.delete_all
Dare.delete_all
Charity.delete_all

users = Array.new(5) do
  User.create!(
    username: Faker::Internet.user_name,
    password: 1234,
    email: Faker::Internet.safe_email,
    uid: Faker::Number.number(10),
    provider: 'Twitter',
    admin: true,
    activated: true,
    activated_at: Time.zone.now
  )
end


 top_10_followed_charities = HTTParty.get('https://www.kimonolabs.com/api/e8cai98q?apikey=jR0ep0PlzRAYmFSLYW4sScLoay3VFcDE')

  charities_array = top_10_followed_charities["results"]["collection1"]





charities_array.each do |charity|
  Charity.create!(
    name: charity["title"]["text"],
    followers: charity["Followers"],
    url: charity["title"]["href"],
    description: "Click on link for more charity info",
    )
end


File.open('./db/dares.csv').each do |line|
  GenerateDare.create!(description: "#{line.chomp}")
end




5.times do

  charity = Charity.order("RANDOM()").first

  users.rotate!

  a, b, c, d, e = users

  dare = Dare.new(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
  )

  a.proposed_dares << dare
  b.challenged_dares << dare
  dare.donations.create!(user: c, donation_amount: 2)
  dare.donations.create!(user: d, donation_amount: 2)
  dare.donations.create!(user: e, donation_amount: 2)
  charity.dares << dare

  p dare.proposer == a
  p dare.daree == b
  p c.pledged_dares.first == dare
  p d.pledged_dares.first == dare
  p e.pledged_dares.first == dare
  p dare.charity == charity

  dare.save
end
