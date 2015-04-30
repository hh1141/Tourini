class RemovePhotoFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :photo, :string
  end
end
