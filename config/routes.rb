JsonRails::Application.routes.draw do
  resources :movies, only: [:index, :show, :update, :create]
  root to: "static_pages#index"
end
