# coding: utf-8

ActiveRecord::Base.transaction do
  20.times do |index|
    item =
      Item.create!(
        :title => "#{Faker::Lorem.sentence} – #{index}",
        :text => Faker::Lorem.paragraphs.join("\n"),
      )

    item.collection_list << Item::COLLECTIONS[:home]
    item.collection_list << Item::COLLECTIONS.values.sample
    item.save!

    rand(3).times do |index|
      item.pics.create!(
        :attach => File.open("#{Rails.root}/test/fixtures/pic_big.jpg")
      )
    end

    puts "Created item [#{item.id}] – #{item.title}"
  end

  email = "email@email.com"
  password = "2013pa$$"

  admin_user =
    AdminUser.create!(
      :name => "Super Admin",
      :email => email,
      :password => password,
      :password_confirmation => password
    )

  puts "AdminUser created #{email}/#{password}"
end