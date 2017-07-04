class AddDefaultForList < ActiveRecord::Migration[5.1]
  def change
     change_column :lists, :status, :string, default: 'incompleted'
  end
end
