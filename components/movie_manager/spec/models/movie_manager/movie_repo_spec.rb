require "rails_helper"

module MovieManager
  RSpec.describe MovieRepo do
    describe "all movies" do
      it "returns all the persisted movies" do
        create_movie(title: "Foo", director: "Bar")

        result = MovieRepo.all

        expect(result.count).to eq 1
        expect(result.first.id).not_to be_nil
        expect(result.first.title).to eq "Foo"
        expect(result.first.director).to eq "Bar"
      end

      it "returns an empty collection when no movies exist" do
        expect(MovieRepo.all).to eq []
      end

      it "returns value objects instead of Active Record objects" do
        create_movie(title: "Foo", director: "Bar")

        result = MovieRepo.all

        expect(result.first.is_a?(Movie)).to eq true
        expect(result.first.id).to be_present
        expect(result.first.title).to eq "Foo"
        expect(result.first.director).to eq "Bar"
      end
    end

    describe "querying movies" do
      it "finds movies based on an ID" do
        movie = create_movie(title: "Foo", director: "Bar")

        found_movie = MovieRepo.find(movie.id)

        expect(found_movie.id).to eq movie.id
        expect(found_movie.title).to eq "Foo"
        expect(found_movie.director).to eq "Bar"
      end

      it "returns nil when a movie is not found" do
        expect(MovieRepo.find(bogus_id = 123)).to be_nil
      end
    end

    describe "persisting movies" do
      it "stores movies in the database" do
        persisted_movie = MovieRepo.persist(title: "The Shining",
                                            director: "Stanley Kubrick")

        expect(persisted_movie.id).to be_present
      end

      it "returns value objects after persisting movie data" do
        persisted_movie = MovieRepo.persist(title: "The Shining",
                                            director: "Stanley Kubrick")

        expect(persisted_movie.is_a?(Movie)).to eq true
      end

      it "raises an error when persiting data fails" do
        allow(MovieRepo::Movie).to receive(:create!).and_raise

        expect {
          MovieRepo.persist(garbage: :data)
        }.to raise_error(MovieRepo::PersistFailedError)
      end
    end

    describe "updating movies" do
      it "updates a movie" do
        movie = create_movie(title: "Foo", director: "Bar")

        updated = MovieRepo.update(movie, title: "Oof", director: "Rab")

        expect(updated.id).to eq movie.id
        expect(updated.title).to eq "Oof"
        expect(updated.director).to eq "Rab"

        sanity_check = MovieRepo.find(updated.id)
        expect(sanity_check.id).to eq movie.id
        expect(sanity_check.title).to eq "Oof"
        expect(sanity_check.director).to eq "Rab"
      end

      it "accepts partial updates" do
        movie = create_movie(title: "Foo", director: "Bar")

        updated = MovieRepo.update(movie, title: "Oof")

        expect(updated.id).to eq movie.id
        expect(updated.title).to eq "Oof"
        expect(updated.director).to eq "Bar"
      end
    end

    describe "deleting movies" do
      it "deletes movies from the database" do
        movie = create_movie

        result = MovieRepo.delete(movie)

        expect(result).to eq true
        expect(MovieRepo.all).to eq []
      end

      it "returns false when the delete fails" do
        FakeMovie = Struct.new(:id)

        result = MovieRepo.delete(FakeMovie.new(123))

        expect(result).to eq false
      end
    end
  end
end
