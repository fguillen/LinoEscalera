class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title, :null => false
      t.text :text
      t.text :text_es
      t.text :video_script
      t.attachment :video
      t.integer :position, :null => false

      t.timestamps
    end
  end
end
