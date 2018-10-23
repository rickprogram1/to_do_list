User.create!(name:  "Example User",
    password:              "foobar",
    password_confirmation: "foobar",
    admin: true)

99.times do |n|
name  = Faker::Name.name
password = "password"
User.create!(name:  name,
      password:              password,
      password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.tasks.create!(content: content) }
end