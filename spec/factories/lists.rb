FactoryGirl.define do
  factory :list do
    title { FFaker::Name.name }
    description { FFaker::Lorem.phrase }
	user_id "1"
  end
end
