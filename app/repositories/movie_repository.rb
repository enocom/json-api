class MovieRepository

  def create(attributes)
    created_movie = Movie.create(attributes)

    MovieEntity.new(
      :id       => created_movie.id,
      :title    => created_movie.title,
      :director => created_movie.director
    )
  end

  def update(id, attributes)
    updated_movie = Movie.update(id, attributes)

    MovieEntity.new(
      :id       => updated_movie.id,
      :title    => updated_movie.title,
      :director => updated_movie.director
    )
  end

  def find_by_id(id)
    found_movie = Movie.find(id)

    MovieEntity.new(
      :id       => found_movie.id,
      :title    => found_movie.title,
      :director => found_movie.director
    )
  end

  def destroy(movie_id)
    destroyed_movie = Movie.destroy(movie_id)

    MovieEntity.new(
      :id       => destroyed_movie.id,
      :title    => destroyed_movie.title,
      :director => destroyed_movie.director
    )
  end

  def all
    Movie.all.map do |m|
      MovieEntity.new(
        :id       => m.id,
        :title    => m.title,
        :director => m.director
      )
    end
  end

end
