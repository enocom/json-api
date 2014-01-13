JsonRails::Application.routes.draw do
  devise_for :users
  resources :movies, only: [:index, :show, :update, :create, :destroy]
  root to: "static_pages#index"
end
