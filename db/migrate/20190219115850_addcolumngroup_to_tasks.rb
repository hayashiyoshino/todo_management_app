class AddcolumngroupToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :group_id, :integer
  end
end
