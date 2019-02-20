Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources 'users'
  resources 'groups', only: [:new, :create]

  namespace :admin do
    resources :users do
      collection do
        get '/:id/user_tasks', to: 'users#user_tasks'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks
  root 'tasks#index'
end
