JsonRails::Application.routes.draw do
  devise_for :users, controllers: { sessions: "sessions" }
  resources :movies, only: [:index, :show, :update, :create, :destroy]
  root to: "static_pages#index"
end
