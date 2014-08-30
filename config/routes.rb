JsonRails::Application.routes.draw do
  namespace :api do
    resources :movies, only: [:index, :show, :update, :create, :destroy]
  end
end
