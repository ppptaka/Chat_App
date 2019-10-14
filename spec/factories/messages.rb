FactoryBot.define do
  factory :message do
    id {"1"}
    body {"test"}
    user_id {1}
    chat_room_id {10}
  end
end
