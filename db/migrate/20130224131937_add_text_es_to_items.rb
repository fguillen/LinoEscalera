class AddTextEsToItems < ActiveRecord::Migration
  def change
    add_column :items, :text_es, :text
  end
end
