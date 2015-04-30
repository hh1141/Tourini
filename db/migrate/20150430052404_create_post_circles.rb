class CreatePostCircles < ActiveRecord::Migration
  def change
    create_table :post_circles do |t|
      t.integer :post_id
      t.integer :circle_id

      t.timestamps null: false
    end
  end
end
