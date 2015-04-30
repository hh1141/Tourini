class DropPostCircle < ActiveRecord::Migration
  def down
    drop_table :PostCircle
  end 
end
