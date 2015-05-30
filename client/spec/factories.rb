FactoryGirl.define do  factory :generate_dare do
    description "MyString"
  end

  factory :user do
    username Faker::Name.name
    password Faker::Internet.password
    email Faker::Internet.email
    provider "twitter"
    uid Faker::Number.number(8)
    image_url Faker::Avatar.image
  end
end

FactoryGirl.define do  factory :generate_dare do
    description "MyString"
  end

  factory :dare do
   title Faker::Lorem.sentence
   description Faker::Lorem.paragraph
   daree_id (1..100).to_a.sample
   proposer_id (1..100).to_a.sample
   charity_id (1..100).to_a.sample
  end
end
