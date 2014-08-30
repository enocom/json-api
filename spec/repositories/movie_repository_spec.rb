require "rails_helper"

describe MovieRepository do
  let(:repository) { MovieRepository.new }

  it "creates movies as Movie objects" do
    expect {
      repository.create(:title => "Rashomon", :director => "Kurozawa Akira")
    }.to change(Movie, :count).by(1)
  end

  it "returns movie entities" do
    movie = repository.create(:title => "Rashomon", :director => "Kurozawa Akira")
    expect(movie).to be_kind_of(MovieEntity)
  end

  it "returns all the movies" do
    Movie.create(:title => "Rear Window", :director => "Alfred Hitchcock")
    Movie.create(:title => "Psycho", :director => "Alfred Hitchcock")
    all_movies = repository.all

    expect(all_movies.map(&:title)).to match_array(["Rear Window", "Psycho"])
  end

  it "finds a movie by id" do
    created_movie = Movie.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    expect(repository.find_by_id(created_movie.id).title).to eq "Rear Window"
  end

  it "updates a movie by id" do
    created_movie = Movie.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    updated_movie = repository.update(created_movie.id, :title => "North by Northwest")

    expect(updated_movie.title).to eq "North by Northwest"
  end

  describe "error handling" do
    it "raises when passed incomplete arguments during creation" do
      expect {
        repository.create(:title => "Rashomon", :director => "")
      }.to raise_error(MovieRepository::MissingArgumentError)

      expect {
        repository.create(:director => "Kurozawa Akira")
      }.to raise_error(MovieRepository::MissingArgumentError)
    end

    it "raises when trying to lookup an non-existant record" do
      expect {
        repository.find_by_id(bad_movie_id = 123)
      }.to raise_error(MovieRepository::RecordNotFoundError)
    end

    it "raises when tring to update a non-existant record" do
      expect {
        repository.update(bad_movie_id = 123, { title: "The Shining"})
      }.to raise_error(MovieRepository::RecordNotFoundError)
    end

    it "raise an error when finding a movie fails" do
      expect {
        repository.find_by_id(bad_movie_id = 123)
      }.to raise_error(MovieRepository::RecordNotFoundError)
    end

    it "raise an error when deleting a movie fails" do
      expect {
        repository.destroy(bad_movie_id = 123)
      }.to raise_error(MovieRepository::RecordNotFoundError)
    end

  end
end
