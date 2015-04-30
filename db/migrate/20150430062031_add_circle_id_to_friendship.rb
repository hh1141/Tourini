class AddCircleIdToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :circle_id, :integer
  end
end
