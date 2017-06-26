class AddPriorityIdToLists < ActiveRecord::Migration[5.1]
  def change
    add_column :lists , :priority_id , :integer
    add_index :lists , :priority_id
  end
end
