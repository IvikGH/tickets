FactoryGirl.define do
  factory :status do
    title { Faker::Hacker.verb }
  end

  before(:create) do
    title = 'Waiting for Staff Response'
    Status.find_by_title(title) || Status.create(title: title)
  end
end
