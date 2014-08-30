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

  it "raises when passed incomplete arguments during creation" do
    expect {
      repository.create(:title => "Rashomon", :director => "")
    }.to raise_error(MovieRepository::MissingArgumentError)

    expect {
      repository.create(:director => "Kurozawa Akira")
    }.to raise_error(MovieRepository::MissingArgumentError)
  end

  it "destroys a movie by id" do
    created_movie = repository.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    repository.destroy(created_movie.id)

    expect {
      repository.find_by_id(created_movie.id)
    }.to raise_error(MovieRepository::RecordNotFoundError)
  end

  it "returns all the movies" do
    repository.create(:title => "Rear Window", :director => "Alfred Hitchcock")
    repository.create(:title => "Psycho", :director => "Alfred Hitchcock")
    all_movies = repository.all

    expect(all_movies.map(&:title)).to match_array(["Rear Window", "Psycho"])
  end

  it "finds a movie by id" do
    created_movie = repository.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    expect(repository.find_by_id(created_movie.id).title)
      .to eq "Rear Window"
  end

  it "raise an error when it cannot find a movie by id" do
    expect {
      repository.find_by_id(bad_movie_id = 123)
    }.to raise_error(MovieRepository::RecordNotFoundError)
  end

  it "updates a movie by id" do
    created_movie = repository.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    repository.update(created_movie.id, :title => "North by Northwest")
    updated_movie = repository.find_by_id(created_movie.id)

    expect(updated_movie.title).to eq "North by Northwest"
  end
end
