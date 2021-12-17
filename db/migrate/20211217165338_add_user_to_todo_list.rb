class AddUserToTodoList < ActiveRecord::Migration[6.1]
  def change
    add_reference :todo_lists, :user, null: false, foreign_key: true, type: :uuid
  end
end
