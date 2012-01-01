FactoryGirl.define do
  factory :user do
    email "user@example.com"
    phone "+41797150317"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :message do
    callsid "12345"
    from "+411230001"
    url "http://localhost/1"
    received DateTime.now

    user
  end

  factory :second_message, class: :message do
    callsid "12346"
    from "+411230002"
    url "http://localhost/2"
    received DateTime.now

    user
  end
end
