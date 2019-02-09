Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks do
    collection do
      get 'sort_deadline'
      get 'narrow_down_status'
    end
  end
  root 'tasks#index'
end
