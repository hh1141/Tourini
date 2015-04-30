class DropTable < ActiveRecord::Migration
  def change
    drop_table :PostCircle
  end 
end
