JsonRails::Application.routes.draw do
  resources :movies, only: [:index, :show, :update, :create]
end
