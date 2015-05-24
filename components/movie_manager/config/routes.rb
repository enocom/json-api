MovieManager::Engine.routes.draw do
  resources :movies, only: [:index, :show, :update, :create, :destroy]
end
