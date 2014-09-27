require "rails_helper"

describe MovieRepository do
  let(:repository) { MovieRepository.new }

  it "creates movies in the database" do
    expect {
      repository.create(:title => "Rashomon", :director => "Kurozawa Akira")
    }.to change(MovieDao, :count).by(1)
  end

  it "returns movie entities (and not Active Record objects)" do
    movie = repository.create(:title => "Rashomon", :director => "Kurozawa Akira")
    expect(movie).to be_kind_of(MovieEntity)
  end

  it "returns all the persisted movies" do
    MovieDao.create(:title => "Rear Window", :director => "Alfred Hitchcock")
    MovieDao.create(:title => "Psycho", :director => "Alfred Hitchcock")
    all_movies = repository.all

    expect(all_movies.map(&:title)).to match_array(["Rear Window", "Psycho"])
  end

  it "finds a movie by id" do
    created_movie = MovieDao.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    expect(repository.find_by_id(created_movie.id).title).to eq "Rear Window"
  end

  it "updates a movie by id" do
    created_movie = MovieDao.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    updated_movie = repository.update(created_movie.id, :title => "North by Northwest")

    expect(updated_movie.title).to eq "North by Northwest"
  end

  it "deletes movies from the database" do
    created_movie = MovieDao.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    repository.destroy(created_movie.id)

    expect(MovieDao.count).to be_zero
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

    it "raises when trying to lookup a non-existant record" do
      expect {
        repository.find_by_id(bad_movie_id = 123)
      }.to raise_error(MovieRepository::RecordNotFoundError)
    end

    it "raises when trying to update a non-existant record" do
      expect {
        repository.update(bad_movie_id = 123, { title: "The Shining"})
      }.to raise_error(MovieRepository::RecordNotFoundError)
    end

    it "raises when trying to update a record to be invalid" do
      existing_movie = MovieDao.create(title: "The Shawshank Redemption",
                                       director: "Frank Durabont")

      expect {
        repository.update(existing_movie.id, { title: ""})
      }.to raise_error(MovieRepository::MissingArgumentError)
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
