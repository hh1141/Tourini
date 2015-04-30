class AddAnswerToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :answer, :boolean
  end
end
