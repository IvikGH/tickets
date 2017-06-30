FactoryGirl.define do
  factory :status do
    title { Faker::Hacker.verb }
  end
end
