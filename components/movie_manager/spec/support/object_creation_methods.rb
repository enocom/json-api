module ObjectCreationMethods
  def create_movie(overrides = {})
    new_movie(overrides).tap(&:save!)
  end

  def new_movie(overrides = {})
    defaults = {
        title: "The Shining",
        director: "Stanley Kubrick"

    }

    MovieManager::MovieRepo::Movie.new(defaults.merge(overrides))
  end
end
