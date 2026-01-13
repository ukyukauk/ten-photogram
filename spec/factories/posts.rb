FactoryBot.define do
  factory :post do
    content { Faker::Lorem.characters(number: 20) }

    trait :with_image do
      after :build do |post|
        post.images.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/test_image.png')),
          filename: 'test_image.png',
          content_type: 'image/png'
        )
      end
    end
  end
end
