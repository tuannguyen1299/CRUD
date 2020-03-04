FactoryGirl.define do
  factory :post do |f|
    f.title {Faker::Lorem.word}
    f.describe{Faker::Lorem.word}
    f.content{Faker::Lorem.word}
    f.image {Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "jpg")}
  end
end

# FactoryBot.define do
#   factory :post do |f|
#     f.title {Faker::Lorem.word}
#     f.describe{Faker::Lorem.word}
#     f.content{Faker::Lorem.word}
#     f.image {Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "jpg")}
#   end
# end
