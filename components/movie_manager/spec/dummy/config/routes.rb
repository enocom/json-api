Rails.application.routes.draw do
  mount MovieManager::Engine => "/"
end
