FactoryBot.define do
  factory :message do
    body      {"こんにちは！"}
    image     {File.open("#{Rails.root}/public/images/test_image.jpg")}
    group
    user
  end
end