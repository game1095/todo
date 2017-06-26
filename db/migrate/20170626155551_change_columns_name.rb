class ChangeColumnsName < ActiveRecord::Migration[5.1]
  def change
    rename_column :lists , :finishedDate , :dateline
  end
end
