Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :v1 do
    resources :projects, only: [:index, :show, :create]
    resources :tasks, only: [:index, :create, :update, :destroy]
  end
end
