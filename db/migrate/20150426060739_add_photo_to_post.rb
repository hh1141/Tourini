class AddPhotoToPost < ActiveRecord::Migration
  def change
    add_column :posts, :photo, :bytea
  end
end
