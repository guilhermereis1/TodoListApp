module TodoListItemsHelper

 def status_item(item)
  if item.completed then
   link_to I18n.t('views.todo_list.show.statues.pending'), update_status_task_path(item), method: :put, class: 'btn btn-danger'
  else
   link_to I18n.t('views.todo_list.show.statues.done'), update_status_task_path(item), method: :put, class: 'btn btn-success'
  end
 end
end
