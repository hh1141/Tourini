class AddCircleIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :circle_id, :integer
  end
end
