class AddHtml5ActiveToItem < ActiveRecord::Migration
  def change
    add_column :items, :html5_active, :boolean, :default => true
  end
end
