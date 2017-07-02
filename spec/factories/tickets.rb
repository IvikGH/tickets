FactoryGirl.define do
  factory :ticket do
    department_id   { Department.last.id }
    status_id       { Status.find_by_title('Waiting for Staff Response').id }
    subject         { "#{Faker::Hacker.ingverb} #{Faker::Hacker.abbreviation}" }
    description     { Faker::Hacker.say_something_smart }
    employee        { Faker::Name.name }
    employee_email  { Faker::Internet.email }
    uniq_reference  { ReferenceGenerator.generate_reference }
  end
end
