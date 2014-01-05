require "spec_helper"

describe "movies API" do
  describe "GET /movies" do
    it "returns all the movies" do
      FactoryGirl.create :movie, title: "The Hobbit"
      FactoryGirl.create :movie, title: "The Fellowship of the Ring"

      get "/movies", {}, { "HTTP_ACCEPT" => "application/json" }

      body = JSON.parse(response.body)
      movie_titles = body.map { |m| m["title"] }

      expect(movie_titles).to match_array(["The Hobbit",
                                           "The Fellowship of the Ring"])
    end
  end

  describe "GET /movies/:id" do
    it "returns a requested movie" do
      m = FactoryGirl.create :movie, title: "2001: A Space Odyssy"

      get "/movies/#{m.id}", {}, { "HTTP_ACCEPT" => "application/json" }

      expect(response.status).to be 200

      body = JSON.parse(response.body)
      expect(body["title"]).to eq "2001: A Space Odyssy"
    end
  end

  describe "PUT /movies/:id" do
    it "updates a movie" do
      m = FactoryGirl.create :movie, title: "Star Battles"

      put "/movies/#{m.id}",
          { movie: { title: "Star Wars" } }.to_json,
          { "HTTP_ACCEPT" => "application/json",
            "CONTENT_TYPE" => "application/json" }

      expect(response.status).to be 204
      expect(m.reload.title).to eq "Star Wars"
    end
  end

  describe "POST /movies" do
    it "creates a movie" do
      post "/movies",
           { movie: { title: "The Empire Strikes Back" } }.to_json,
          { "HTTP_ACCEPT" => "application/json",
            "CONTENT_TYPE" => "application/json" }

      expect(response.status).to be 201
      expect(response["Location"]).to include "/movies/#{Movie.first.id}"
    end
  end

  describe "DELETE /movies/:id" do
    it "deletes a movie" do
      m = FactoryGirl.create :movie, title: "The Shining"

      delete "/movies/#{m.id}", {}, { "HTTP_ACCEPT" => "application/json" }

      expect(response.status).to be 204
      expect(Movie.count).to eq 0
    end
  end
end
