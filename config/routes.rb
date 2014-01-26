JsonRails::Application.routes.draw do
  devise_for :users, controllers: { sessions: "sessions" }

  namespace :api do
    resources :movies, only: [:index, :show, :update, :create, :destroy]
  end

  root to: 'main#index'
end
