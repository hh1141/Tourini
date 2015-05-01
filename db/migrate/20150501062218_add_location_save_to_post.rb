class AddLocationSaveToPost < ActiveRecord::Migration
  def change
    add_column :posts, :location_save, :boolean
  end
end
