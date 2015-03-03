class Movie
  attr_reader :id, :title, :director

  def initialize(title:, director:)
    @title = title
    @director = director
  end

  def to_h
    {
      id: id,
      title: title,
      director: director
    }
  end
end
