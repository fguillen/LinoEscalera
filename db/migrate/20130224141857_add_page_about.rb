class AddPageAbout < ActiveRecord::Migration
  def up
    Page.create!(
      :title => "About",
      :text => "About text",
      :text_es => "About text es"
    )
  end

  def down
    Page.where(:title => "About").destroy_all
  end
end
