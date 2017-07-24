class AddProjectIdToLists < ActiveRecord::Migration[5.1]
  def change
    add_column :lists , :project_id , :integer
    add_index :lists , :project_id
  end
end
