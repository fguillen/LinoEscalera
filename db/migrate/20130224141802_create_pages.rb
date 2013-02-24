class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, :null => false
      t.text :text, :null => false
      t.text :text_es

      t.timestamps
    end
  end
end
