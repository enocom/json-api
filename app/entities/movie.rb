require "oj"

class Movie
  attr_reader :id, :title, :director

  def initialize(title:, director:)
    @title = title
    @director = director
  end

  def as_json(options = {})
    {
      "id" => id,
      "title" => title,
      "director" => director
    }
  end

  def to_json(options = {})
    Oj.dump(as_json)
  end
end
