class AddDescribeToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :describe, :text, null: true
  end
end
