require_relative "../../app/services/movie_service"
require_relative "../../app/repositories/movie_repository"
require_relative "../../app/entities/movie_entity"

describe MovieService do
  let(:fake_repo) { instance_double(MovieRepository) }

  it "tells the repository to update a record" do
    allow(fake_repo).to receive(:update)

    MovieService.new(fake_repo).update(123, { title: "Rear Window" })

    expect(fake_repo).to have_received(:update) do |received_entity|
      expect(received_entity.title).to eq "Rear Window"
    end
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
    allow(fake_repo).to receive(:add)

    MovieService.new(fake_repo).
      create(title: "Akira", director: "Katsuhiro Otomo")

    expect(fake_repo).to have_received(:add) do |received_entity|
      expect(received_entity.title).to eq "Akira"
      expect(received_entity.director).to eq "Katsuhiro Otomo"
    end
  end

  it "delegates deletion responsibility to the responsitory" do
    allow(fake_repo).to receive(:destroy)

    movie_to_delete_id = 123
    MovieService.new(fake_repo).destroy(movie_to_delete_id)

    expect(fake_repo).to have_received(:destroy).with(movie_to_delete_id)
  end

end
