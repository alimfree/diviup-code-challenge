FactoryGirl.define do
  factory :task do
    user
    list
    title { FFaker::Name.name }
    description { FFaker::Lorem.phrase }
    complete false
  end
end
