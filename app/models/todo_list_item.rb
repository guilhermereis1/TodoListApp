class TodoListItem < ApplicationRecord
  validates_presence_of :name
  belongs_to :todo_list
end
