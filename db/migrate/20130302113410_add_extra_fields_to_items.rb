class AddExtraFieldsToItems < ActiveRecord::Migration
  def change
    add_column :items, :video_script_active, :boolean, :default => true
    add_column :items, :video_active, :boolean, :default => true
  end
end
