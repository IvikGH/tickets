FactoryGirl.define do
  factory :department do
    title { Faker::Commerce.department }
  end
end
