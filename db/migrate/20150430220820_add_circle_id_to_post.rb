class AddCircleIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :circle_id, :integer
  end
end
