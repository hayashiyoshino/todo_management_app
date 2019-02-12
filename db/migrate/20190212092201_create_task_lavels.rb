class CreateTaskLavels < ActiveRecord::Migration[5.2]
  def change
    create_table :task_lavels do |t|
      t.integer :task_id
      t.integer :lavel_id
      t.timestamps
    end
  end
end
