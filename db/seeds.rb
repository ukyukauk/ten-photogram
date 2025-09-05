# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

john = User.find_by(account: 'John')
emily = User.find_by(account: 'emily')

image_paths = Dir[Rails.root.join("db/seed_images/*.{jpg,jpeg,png,webp}")]

5.times do

  post = john.posts.new(
    content: Faker::Lorem.sentence(word_count: 10)
  )

  image_paths.sample(rand(1..3)).each do |path|
    io = File.open(path)
    post.images.attach(
      io: io,
      filename: File.basename(path)
    )
  end

  post.save!

end

5.times do

  post = emily.posts.new(
    content: Faker::Lorem.sentence(word_count: 10)
  )

  image_paths.sample(rand(1..3)).each do |path|
    io = File.open(path)
    post.images.attach(
      io: io,
      filename: File.basename(path)
    )
  end

  post.save!

end
