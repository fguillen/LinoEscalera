FactoryGirl.define do
  factory :admin_user do
    sequence(:name) { |n| "AdminUser Name #{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    password "pass"
    password_confirmation "pass"
  end

  factory :item do
    sequence(:title) { |n| "Item Title #{n}" }
    text "The text"
  end

  factory :pic do
    association :item
    attach { File.new("#{Rails.root}/test/fixtures/pic.jpg") }
  end

  factory :video do
    association :item
    attach { File.new("#{Rails.root}/test/fixtures/pic.jpg") }
  end

  factory :page do
    sequence(:title) { |n| "Page Title #{n}" }
    text "The text"
  end

end