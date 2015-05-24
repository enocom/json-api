JsonRails::Application.routes.draw do
  mount Documentation::Engine, at: "/"
  mount MovieManager::Engine, at: "/api"
end
