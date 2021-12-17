Rails.application.routes.draw do
  devise_for :users
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'set_locale_en', to: 'application#set_locale_en'
  get 'set_locale_pt', to: 'application#set_locale_pt'
  put 'update_status_task/:id', to: 'todo_list_items#update_status_task', as: 'update_status_task'
  resources :todo_list_items
  resources :todo_lists
  root to: 'todo_lists#index'
end
