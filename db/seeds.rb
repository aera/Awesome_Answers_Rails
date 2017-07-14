# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PASSWORD = 'supersecret'

Answer.destroy_all
Question.destroy_all
User.destroy_all

User.create first_name: 'Jon', last_name: 'Snow', email: 'js@winterfell.gov', password: PASSWORD

10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}-#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end

users = User.all

100.times do
  Question.create title: Faker::ChuckNorris.fact,
                  body: Faker::Hacker.say_something_smart,
                  view_count: rand(1000),
                  user: users.sample

end

questions = Question.all

questions.each do |question|
  rand(1..5).times do
    Answer.create(
      body: Faker::RickAndMorty.quote,
      question: question,
      user: users.sample
    )
  end
end

answers = Answer.all

puts Cowsay.say("Created #{users.count} users", :tux)
puts Cowsay.say('Created 100 questions', :cow)
puts Cowsay.say("Created #{answers.count} answers", :ghostbusters)
