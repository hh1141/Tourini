class AddLocationIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :location_id, :integer
  end
end
