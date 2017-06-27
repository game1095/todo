class AddStartDateToList < ActiveRecord::Migration[5.1]
  def change
    add_column :lists , :startdate , :date 
  end
end
