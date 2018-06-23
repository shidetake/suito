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

# category
food = Category.create!(name: '食費')
Category.create!(name: '朝ごはん', parent_id: food.id)
Category.create!(name: '昼ごはん', parent_id: food.id)
Category.create!(name: '夜ごはん', parent_id: food.id)

hobby = Category.create!(name: '趣味')
Category.create!(name: '野球', parent_id: hobby.id)
Category.create!(name: '旅行', parent_id: hobby.id)

Category.create!(name: 'その他')

# group
Group.create!(name: '')
Group.create!(name: 'オーストラリア')
Group.create!(name: '軽井沢')

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each do |user|
    user.transactions.create!(zaim_id: 0,
                              group_id: rand(1..3),
                              valid_record: true,
                              content: content,
                              yen: 100,
                              rate: 1.0,
                              category_id: rand(1..8),
                              source_id: 0,
                              store_id: 0,
                              wallet_id: 0,
                              memo: 'memo'
                             )
  end
end
