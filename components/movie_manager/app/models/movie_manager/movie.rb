module MovieManager
  class Movie
    attr_reader :id, :title, :director

    def initialize(id, title, director)
      @id = id
      @title = title
      @director = director
    end

    def attributes
      {
          id: id,
          title: title,
          director: director
      }
    end
  end
end
