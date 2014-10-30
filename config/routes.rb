JsonRails::Application.routes.draw do
  root to: "root#index"

  namespace :api do
    resources :movies, only: [:index, :show, :update, :create, :destroy]
  end
end
