JsonRails::Application.routes.draw do
  resources :movies, only: [:index, :show, :update, :create, :destroy]
  root to: "static_pages#index"
end
