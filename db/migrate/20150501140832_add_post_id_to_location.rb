class AddPostIdToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :post_id, :integer
  end
end
