namespace :dev do

  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        image: File.open(Rails.root.join("public/seed-img/0#{rand(1..9)}.png"))
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      user_name = FFaker::Name.first_name
      User.create!(
        name: user_name,
        email:"#{user_name}@example.com",
        password:"12345678"
    end
    puts "created fake_user"
    puts "#{User.count} users" 
  end

  task fake_comment: :environment do
    Comment.destroy_all
    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
        )
      end
    end
    puts "create comments"
    puts "#{Comment.count} comment data"
  end

  task load_category: :environment do
    Category.destroy_all
    category_list =[
      { name: "中式料理" },
      { name: "日本料理" },
      { name: "義大利料理" },
      { name: "墨西哥料理" },
      { name: "素食料理" },
      { name: "美式料理" },
      { name: "複合式料理" }
    ]

    category_list.each do |category|
      Category.create( name: category[:name] )
    end
    puts "Category created!"
  end

end
