require 'faker'

User.delete_all
Dare.delete_all
Charity.delete_all
Video.delete_all
Comment.delete_all
Relationship.delete_all


users = Array.new(5) do
  User.create!(
    username: Faker::Internet.user_name,
    password: "123456",
    email: Faker::Internet.safe_email,
    uid: Faker::Number.number(10),
    provider: 'Twitter',
    image_url: Faker::Avatar.image("my-own-slug", "50x50"),
    admin: true,
    image_url: "https://robohash.org/#{Faker::Name.last_name}.png",
    activated: true,
    activated_at: Time.zone.now
  )
end

a_e_charities = HTTParty.get('https://www.kimonolabs.com/api/ci5w4v76?apikey=jR0ep0PlzRAYmFSLYW4sScLoay3VFcDE')
charities_array = a_e_charities["results"]["collection1"]
charities_array = charities_array.shift(50)


charities_array.each do |charity|
  Charity.create!(
    name: charity["title"],
    url: charity["url"],
    mission: charity["misson"],
    transparency_score: charity["transparency score"],
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

  Relationship.create!(
    follower: a,
    followee: b
  )
  Relationship.create!(
    follower: a,
    followee: c
  )
end

p first_user = User.first
p second_user = User.second
p first_dare = Dare.first
p second_dare = Dare.second

Comment.create(body: Faker::Lorem.sentence, author_id: first_user.id, dare_id: first_dare.id)
Comment.create(body: Faker::Lorem.sentence, author_id: second_user.id, dare_id: first_dare.id)


Video.create(title: "testing", url: "https://www.youtube.com/watch?v=Y2bNfUNUpRk", dare_id: first_dare.id, description: "video is for testing", uid: "Y2bNfUNUpRk")
Video.create(title: "testing", url: "https://www.youtube.com/watch?v=Oqa9tKarkNA", dare_id: second_dare.id, description: "video is for testing", uid: "Oqa9tKarkNA")




