require "rails_helper"

describe "movies API", :type => :request do
  let(:accept_json) { { "Accept" => "application/json" } }
  let(:json_content_type) { { "Content-Type" => "application/json" } }
  let(:accept_and_return_json) { accept_json.merge(json_content_type) }
  let(:movie_repository) { MovieRepository.new }

  describe "GET /api/movies" do
    before do
      movie_repository.add(
        MovieEntity.new(
          :title => "The Hobbit",
          :director => "Peter Jackson"
        )
      )
      movie_repository.add(
        MovieEntity.new(
          :title => "The Fellowship of the Ring",
          :director => "Peter Jackson"
        )
      )
    end

    it "returns all the movies" do
      get "/api/movies", {}, accept_json

      expect(response.status).to eq 200

      body            = JSON.parse(response.body)
      movie_titles    = body.map { |m| m["title"] }
      movie_directors = body.map { |m| m["director"] }

      expect(movie_titles).to match_array(["The Hobbit",
                                           "The Fellowship of the Ring"])
      expect(movie_directors).to match_array(["Peter Jackson",
                                              "Peter Jackson"])
    end
  end

  describe "GET /api/movies/:id" do
    let(:movie) do
      movie_repository.add(
        MovieEntity.new(
          :title    => "2001: A Space Odyssy",
          :director => "Stanley Kubrick"
        )
      )
    end

    it "returns a requested movie" do
      get "/api/movies/#{movie.id}", {}, accept_json

      expect(response.status).to be 200

      body = JSON.parse(response.body)
      expect(body["title"]).to eq "2001: A Space Odyssy"
      expect(body["director"]).to eq "Stanley Kubrick"
    end
  end

  describe "PUT /api/movies/:id" do
    let(:movie) do
      movie_repository.add(
        MovieEntity.new(
          :title    => "Star Battles",
          :director => "Leorge Gucas"
        )
      )
    end

    let(:movie_params) do
      { "movie" => { "title" => "Star Wars", "director" => "George Lucas" } }
    end

    it "updates a movie" do
      put "/api/movies/#{movie.id}",
        movie_params.to_json,
        accept_and_return_json

      expect(response.status).to be 200

      body = JSON.parse(response.body)

      expect(body["title"]).to eq "Star Wars"
      expect(body["director"]).to eq "George Lucas"
    end
  end

  describe "POST /api/movies" do
    let(:movie_params) do
      {
        "movie" => {
          "title"    => "Indiana Jones and the Temple of Doom",
          "director" => "Steven Spielberg"
        }
      }
    end

    it "creates a movie" do
      post "/api/movies", movie_params.to_json,
        accept_and_return_json

      expect(response.status).to eq 201
      first_movie = movie_repository.all.first
      expect(response.location).to eq api_movie_path(first_movie.id)

      expect(first_movie.title)
        .to eq "Indiana Jones and the Temple of Doom"
    end

  end

  describe "DELETE /api/movies/:id" do
    let(:movie) do
      movie_repository.add(
        MovieEntity.new(
          :title    => "The Shining",
          :director => "Stanley Kubrick"
        )
      )
    end

    it "deletes a movie" do
      delete "/api/movies/#{movie.id}", {}, accept_json

      expect(response.status).to be 204
    end
  end
end
