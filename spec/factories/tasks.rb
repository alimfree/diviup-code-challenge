FactoryGirl.define do
  factory :task do
    user nil
    list nil
    title "MyString"
    description "MyText"
    complete ""
  end
end
