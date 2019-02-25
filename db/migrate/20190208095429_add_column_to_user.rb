class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :user_id, :integer, index: true
  end
end
