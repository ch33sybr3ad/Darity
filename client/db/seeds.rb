require 'faker'

User.delete_all
Dare.delete_all
Charity.delete_all

client = YouTubeIt::Client.new(:username => ENV['GMAIL'], :password => ENV['GMAIL_PASSWORD'], :dev_key => ENV["YOUTUBE_API_KEY"])
binding.pry

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
end
