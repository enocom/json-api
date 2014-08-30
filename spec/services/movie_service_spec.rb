require_relative "../../app/services/movie_service"
require_relative "../../app/repositories/movie_repository"

describe MovieService do
  let(:fake_repo) { instance_double(MovieRepository) }

  it "tells the repository to update a record" do
    allow(fake_repo).to receive(:update)

    MovieService.new(fake_repo).update(123, { title: "Rear Window" })

    expect(fake_repo).to have_received(:update).with(123, { title: "Rear Window" })
  end

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

  it "delegates creation responsibility to the repository" do
    allow(fake_repo).to receive(:create)

    MovieService.new(fake_repo).create(title: "Akira", director: "Katsuhiro Otomo")

    expect(fake_repo).to have_received(:create).with(title: "Akira",
                                                     director: "Katsuhiro Otomo")
  end

  it "delegates deletion responsibility to the responsitory" do
    allow(fake_repo).to receive(:destroy)

    movie_to_delete_id = 123
    MovieService.new(fake_repo).destroy(movie_to_delete_id)

    expect(fake_repo).to have_received(:destroy).with(movie_to_delete_id)
  end

  describe "error handling" do
    it "raises an error when trying to update a non-existant record" do
      allow(fake_repo).to receive(:update).and_raise(MovieRepository::RecordNotFoundError)

      expect {
        MovieService.new(fake_repo).update(123, { title: "Rear Window" })
      }.to raise_error(MovieService::MovieLookupError)
    end


    it "raises an error when a movie is not found" do
      allow(fake_repo).to receive(:find_by_id).and_raise(MovieRepository::RecordNotFoundError)

      bad_movie_id = 1
      expect {
        MovieService.new(fake_repo).find(bad_movie_id)
      }.to raise_error(MovieService::MovieLookupError)
    end

    it "raises a creation error when the repo fails to create a record" do
      allow(fake_repo).to receive(:create).and_raise(MovieRepository::MissingArgumentError)

      expect {
        MovieService.new(fake_repo).create(title: "Paprika")
      }.to raise_error(MovieService::MovieCreationError)
    end

  end
end
