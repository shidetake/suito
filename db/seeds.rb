User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each do |user|
    user.transactions.create!(zaim_id: 0,
                              group_id: 0,
                              valid_record: true,
                              content: content,
                              yen: 100,
                              rate: 1.0,
                              category_id: 0,
                              genre_id: 0,
                              source_id: 0,
                              store_id: 0,
                              person_id: 0,
                              memo: 'memo'
                             )
  end
end
