require "rails_helper"

describe MovieRepository do
  let(:repository) { MovieRepository.new }

  it "persists movies" do
    movie = MovieEntity.new(
      :title => "Rashomon",
      :director => "Kurozawa Akira"
    )

    expect {
      repository.add(movie)
    }.to change(MovieDao, :count).by(1)
  end

  # it "returns a store result object (and not Active Record objects)" do
  #   result = repository.create(:title => "Rashomon", :director => "Kurozawa Akira")
  #   expect(result).to be_kind_of(PersistenceResult)
  # end

  it "returns all the persisted movies" do
    MovieDao.create(:title => "Rear Window", :director => "Alfred Hitchcock")
    MovieDao.create(:title => "Psycho", :director => "Alfred Hitchcock")

    all_movies = repository.all

    expect(all_movies.map(&:class).uniq.first).to eq MovieEntity
    expect(all_movies.map(&:title)).to match_array(["Rear Window", "Psycho"])
  end

  it "finds a movie by id" do
    created_movie = MovieDao.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    movie = repository.find_by_id(created_movie.id)

    expect(movie.class).to eq MovieEntity
    expect(movie.title).to eq "Rear Window"
  end

  it "updates a movie" do
    persisted_movie = MovieDao.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    movie_with_updated_title = MovieEntity.new(
      :id => persisted_movie.id,
      :title => "North by Northwest",
      :director => persisted_movie.director
    )

    repository.update(movie_with_updated_title)

    expect(persisted_movie.reload.title).to eq "North by Northwest"
  end

  it "deletes movies from the database" do
    persisted_movie = MovieDao.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    repository.destroy(persisted_movie.id)

    expect(MovieDao.count).to be_zero
  end

end
