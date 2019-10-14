FactoryBot.define do
  factory :user do
    id {"1"}
    first_name {"test1"}
    last_name {"test2"}
    email {"test@test"}
    password {"test1123"}
    password_confirmation {"test1123"}
  end
end
