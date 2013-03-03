class AddVideoHeightToItem < ActiveRecord::Migration
  def change
    add_column :items, :video_height, :integer, :default => 480
  end
end
