class TodoList < ApplicationRecord
 validates_presence_of :name
 has_many :todo_list_items, dependent: :destroy
 belongs_to :user
end
