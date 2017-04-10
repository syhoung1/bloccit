require 'random_data'
5.times do
  User.create!(
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end
users = User.all

15.times do
  Topic.create!(
    name: RandomData.random_sentence,
    description: RandomData.random_paragraph
  )
end
topics = Topic.all

50.times do
  Post.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    user: users.sample
  )
end
posts = Post.all

100.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

admin = User.create!(
  name: "admin user",
  email: "admin@admin.com",
  password: "adminadmin",
  role: "admin"
)

moderator = User.create!(
  name: "mod",
  email: "moderator@moderator.com",
  password: "moderatormoderator",
  role: "moderator"
)

member = User.create!(
  name: "john doe",
  email: "john@doe.com",
  password: "mypassword"
  )

puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
