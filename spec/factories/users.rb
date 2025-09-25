FactoryBot.define do
  factory :user do
    account { Faker::Alphanumeric.unique.alpha(number: 8) }
    email { Faker::Internet.unique.email }
    password { 'password' }
  end
end
