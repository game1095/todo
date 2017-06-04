class AddFinishedDateToLists < ActiveRecord::Migration[5.1]
  def change
    add_column :lists  , :finishedDate , :Date
  end
end
