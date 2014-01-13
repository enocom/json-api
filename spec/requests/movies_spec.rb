require "spec_helper"

describe "movies API" do
  let(:user) { FactoryGirl.create :user }
  let(:signed_in_payload) {
    { user_email: user.email,
      user_token: user.authentication_token }
  }
  let(:accept_json) { { "Accept" => "application/json" } }
  let(:json_content_type) { { "Content-Type" => "application/json" } }
  let(:accept_and_return_json) { accept_json.merge(json_content_type) }

  describe "GET /movies" do
    before do
      FactoryGirl.create :movie, title: "The Hobbit"
      FactoryGirl.create :movie, title: "The Fellowship of the Ring"
    end

    context "when signed in" do
      it "returns all the movies" do
        get "/movies", signed_in_payload, accept_json

        expect(response.status).to eq 200

        body = JSON.parse(response.body)
        movie_titles = body.map { |m| m["title"] }

        expect(movie_titles).to match_array(["The Hobbit",
                                             "The Fellowship of the Ring"])
      end
    end

    context "when not signed in" do
      it "returns a 401 status" do
        get "/movies", {}, accept_json
        expect(response.status).to eq 401
      end
    end
  end

  describe "GET /movies/:id" do
    let(:movie) { FactoryGirl.create(:movie, title: "2001: A Space Odyssy") }

    context "when signed in" do
      it "returns a requested movie" do
        get "/movies/#{movie.id}", signed_in_payload, accept_json

        expect(response.status).to be 200

        body = JSON.parse(response.body)
        expect(body["title"]).to eq "2001: A Space Odyssy"
      end
    end

    context "when not signed in" do
      it "returns a 401 status" do
        get "/movies/#{movie.id}", {}, accept_json
        expect(response.status).to be 401
      end
    end
  end

  describe "PUT /movies/:id" do
    let(:movie) { FactoryGirl.create(:movie, title: "Star Battles") }
    let(:movie_params) { { "movie" => { "title" => "Star Wars" } } }

    context "when signed in" do
      it "updates a movie" do
        put "/movies/#{movie.id}",
          movie_params.merge(signed_in_payload).to_json,
          accept_and_return_json

        expect(response.status).to be 204
        expect(movie.reload.title).to eq "Star Wars"
      end
    end

    context "when not signed in" do
      it "returns a 401 status" do
        put "/movies/#{movie.id}", movie_params.to_json, accept_and_return_json
        expect(response.status).to eq 401
      end
    end
  end

  describe "POST /movies" do
    let(:movie_params) {
       { "movie" => { "title" => "Indiana Jones and the Temple of Doom" } }
    }

    context "when signed in" do
      it "creates a movie" do
        post "/movies", movie_params.merge(signed_in_payload).to_json,
          accept_and_return_json

        expect(response.status).to eq 201
        expect(Movie.first.title).to eq "Indiana Jones and the Temple of Doom"
      end
    end

    context "when not signed in" do
      it "returns a 401 status" do
        post "/movies", movie_params.to_json, accept_and_return_json
        expect(response.status).to eq 401
      end
    end
  end

  describe "DELETE /movies/:id" do
    let(:movie) { FactoryGirl.create :movie, title: "The Shining" }

    context "when signed in" do
      it "deletes a movie" do
        delete "/movies/#{movie.id}", signed_in_payload, accept_json

        expect(response.status).to be 204
        expect(Movie.count).to eq 0
      end
    end

    context "when not signed in" do
      it "returns a 401 status" do
        delete "/movies/#{movie.id}", {}, accept_json
        expect(response.status).to be 401
      end
    end
  end
end
