FactoryBot.define do
  factory :user do
    account { 'test' }
    email { Faker::Internet.email }
    password { 'password' }
  end
end
