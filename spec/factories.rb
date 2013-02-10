FactoryGirl.define do
  factory :weird_site do
    sequence(:url) { |n| "http://someweirdsite#{n}.com" }
    sequence(:name) { |n| "Totally Weird #{n}" }
  end
end

FactoryGirl.define do
  factory :admin_user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'ilovelamp11'
    password_confirmation 'ilovelamp11'
    first_name 'Dude'
    last_name 'Doctometus'
    role 'admin'
    status true
  end
end

