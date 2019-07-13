FactoryBot.define do

  factory :group do
    name  { Faker::Creature::Animal.name }
  end

end