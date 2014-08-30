require_relative "../../app/services/movie_service"
require_relative "../../app/repositories/movie_repository"

describe MovieService do
  let(:fake_repo) { instance_double(MovieRepository) }

  it "tells the repository to find a single movie" do
    allow(fake_repo).to receive(:find_by_id)

    movie_id = 1
    MovieService.new(fake_repo).find(movie_id)

    expect(fake_repo).to have_received(:find_by_id).with(movie_id)
  end

  it "returns all movies from the repository" do
    allow(fake_repo).to receive(:all)

    MovieService.new(fake_repo).all

    expect(fake_repo).to have_received(:all)
  end

  it "delegates creation responsibility to a repository" do
    allow(fake_repo).to receive(:create)

    MovieService.new(fake_repo).create(title: "Akira", director: "Katsuhiro Otomo")

    expect(fake_repo).to have_received(:create).with(title: "Akira",
                                                     director: "Katsuhiro Otomo")
  end

  it "raises a creation error when the repo fails to create a record" do
    allow(fake_repo).to receive(:create).and_raise(MovieRepository::MissingArgumentError)

    expect {
      MovieService.new(fake_repo).create(title: "Paprika")
    }.to raise_error(MovieService::MovieCreationError)
  end

end
