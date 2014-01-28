require "spec_helper"

describe "movies API" do
  let(:user) { FactoryGirl.create :user }
  let(:accept_json) { { "Accept" => "application/json" } }
  let(:json_content_type) { { "Content-Type" => "application/json" } }
  let(:accept_and_return_json) { accept_json.merge(json_content_type) }

  describe "GET /api/movies" do
    before do
      FactoryGirl.create :movie, title: "The Hobbit",
        director: "Peter Jackson"
      FactoryGirl.create :movie, title: "The Fellowship of the Ring",
        director: "Peter Jackson"
    end

    it "returns all the movies" do
      get "/api/movies", {}, accept_json

      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      movie_titles = body.map { |m| m["title"] }
      movie_directors = body.map { |m| m["director"] }

      expect(movie_titles).to match_array(["The Hobbit",
                                           "The Fellowship of the Ring"])
      expect(movie_directors).to match_array(["Peter Jackson",
                                              "Peter Jackson"])
    end
  end

  describe "GET /api/movies/:id" do
    let(:movie) { FactoryGirl.create(:movie, title: "2001: A Space Odyssy",
                                     director: "Stanley Kubrick") }

    it "returns a requested movie" do
      get "/api/movies/#{movie.id}", {}, accept_json

      expect(response.status).to be 200

      body = JSON.parse(response.body)
      expect(body["title"]).to eq "2001: A Space Odyssy"
      expect(body["director"]).to eq "Stanley Kubrick"
    end
  end

  describe "PUT /api/movies/:id" do
    let(:movie) { FactoryGirl.create(:movie, title: "Star Battles") }
    let(:movie_params) { { "movie" => { "title" => "Star Wars" } } }

    it "updates a movie" do
      put "/api/movies/#{movie.id}",
      movie_params.to_json,
        accept_and_return_json

      expect(response.status).to be 204
      expect(movie.reload.title).to eq "Star Wars"
    end
  end

  describe "POST /api/movies" do
    let(:movie_params) {
       { "movie" => { "title" => "Indiana Jones and the Temple of Doom" } }
    }

      it "creates a movie" do
        post "/api/movies", movie_params.to_json,
          accept_and_return_json

        expect(response.status).to eq 201
        expect(Api::Movie.first.title).to eq "Indiana Jones and the Temple of Doom"
      end
  end

  describe "DELETE /api/movies/:id" do
    let(:movie) { FactoryGirl.create :movie, title: "The Shining" }

    it "deletes a movie" do
      delete "/api/movies/#{movie.id}", {}, accept_json

      expect(response.status).to be 204
      expect(Api::Movie.count).to eq 0
    end
  end
end
