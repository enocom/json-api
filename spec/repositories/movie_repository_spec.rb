require "rails_helper"

describe MovieRepository do
  describe "all movies" do
    it "returns all the persisted movies" do
      TestObjectFactory.create_movie(title: "Foo", director: "Bar")

      result = MovieRepository.all

      expect(result.count).to eq 1
      expect(result.first.id).not_to be_nil
      expect(result.first.title).to eq "Foo"
      expect(result.first.director).to eq "Bar"
    end

    it "returns an empty collection when no movies exist" do
      expect(MovieRepository.all).to eq []
    end
  end

  describe "querying movies" do
    it "finds movies based on an ID" do
      movie = TestObjectFactory.create_movie(title: "Foo", director: "Bar")

      found_movie = MovieRepository.find(movie.id)

      expect(found_movie.id).to eq movie.id
      expect(found_movie.title).to eq "Foo"
      expect(found_movie.director).to eq "Bar"
    end

    it "returns nil when a movie is not found" do
      expect(MovieRepository.find(bogus_id = 123)).to be_nil
    end
  end

  describe "persisting movies" do
    it "stores movies in the database" do
      movie = Movie.new(title: "The Shining", director: "Stanley Kubrick")

      persisted_movie = MovieRepository.persist(movie)

      expect(persisted_movie.id).to be_present
    end
  end

  describe "updating movies" do
    it "updates a movie" do
      movie = TestObjectFactory.create_movie(title: "Foo", director: "Bar")

      updated = MovieRepository.update(movie, title: "Oof", director: "Rab")

      expect(updated.id).to eq movie.id
      expect(updated.title).to eq "Oof"
      expect(updated.director).to eq "Rab"
    end

    it "accepts partial updates" do
      movie = TestObjectFactory.create_movie(title: "Foo", director: "Bar")

      updated = MovieRepository.update(movie, title: "Oof")

      expect(updated.id).to eq movie.id
      expect(updated.title).to eq "Oof"
      expect(updated.director).to eq "Bar"
    end
  end

  describe "deleting movies" do
    it "deletes movies from the database" do
      movie = TestObjectFactory.create_movie

      result = MovieRepository.delete(movie)

      expect(result).to eq true
      expect(MovieRepository.all).to eq []
    end

    it "returns false when the delete fails" do
      FakeMovie = Struct.new(:id)

      result = MovieRepository.delete(FakeMovie.new(123))

      expect(result).to eq false
    end
  end
end
