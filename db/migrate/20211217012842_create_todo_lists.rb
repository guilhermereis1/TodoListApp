class CreateTodoLists < ActiveRecord::Migration[6.1]
  def change
    create_table :todo_lists, id: :uuid do |t|
      t.string :name, null: false, default: 'New Todo List'

      t.timestamps
    end
  end
end
