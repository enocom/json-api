require "lotus/model"

class Movie
  include Lotus::Entity
  attributes :title, :director
end
