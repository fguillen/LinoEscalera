# coding: utf-8

ActiveRecord::Base.transaction do
  10.times do |index|
    item =
      Item.create!(
        :title => Faker::Lorem.sentence,
        :text => Faker::Lorem.paragraphs.join("\n\n"),
      )

    item.collection_list << Item::COLLECTIONS[:home]
    item.collection_list << Item::COLLECTIONS.values.sample
    item.save!

    (rand(3)+1).times do |index|
      item.pics.create!(
        :attach => File.open("#{Rails.root}/test/fixtures/pic_big.jpg")
      )
    end

    puts "Created item [#{item.id}] – #{item.title}"
  end
end