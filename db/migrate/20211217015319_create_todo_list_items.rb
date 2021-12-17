class CreateTodoListItems < ActiveRecord::Migration[6.1]
  def change
    create_table :todo_list_items, id: :uuid do |t|
      t.string :name, null: false
      t.boolean :completed, null: false, default: false
      t.references :todo_list, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
