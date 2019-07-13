FactoryBot.define do

  factory :user do
    password = Faker::Internet.password(8)
    sequence(:name) {Faker::Name.middle_name}
    sequence(:email) {Faker::Internet.email}
    password              {password}
    password_confirmation {password}
  end

end