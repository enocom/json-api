require "spec_helper"

shared_examples "a movie repository" do

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

describe MovieRepository do
  let(:repository) { MovieRepository.new }

  it "creates movies as Api::Movie objects" do
    expect {
      repository.create(:title => "Rashomon", :director => "Kurozawa Akira")
    }.to change(Api::Movie, :count).by(1)
  end

  it "destroys a movie by id" do
    created_movie = repository.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    repository.destroy(created_movie.id)

    expect {
      repository.find_by_id(created_movie.id)
    }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it_behaves_like "a movie repository"
end

describe FakeMovieRepository do
  let(:repository) { FakeMovieRepository.new }

  it "destroys a movie by id" do
    created_movie = repository.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    repository.destroy(created_movie.id)

    expect(repository.find_by_id(created_movie.id)).to be_nil
  end

  it_behaves_like "a movie repository"
end
