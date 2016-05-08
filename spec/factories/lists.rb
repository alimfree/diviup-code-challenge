FactoryGirl.define do
  factory :list do
    title { FFaker::Name.name }
    description { FFaker::Lorem.phrase }
	user
  end
end
