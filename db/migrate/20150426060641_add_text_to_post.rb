class AddTextToPost < ActiveRecord::Migration
  def change
    add_column :posts, :text, :text
  end
end
