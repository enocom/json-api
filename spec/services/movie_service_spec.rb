require_relative "../../app/services/movie_service"
require_relative "../../app/repositories/movie_repository"

describe MovieService do
  it "delegates creation responsibility to a repository" do
    fake_repo = instance_double(MovieRepository)
    allow(fake_repo).to receive(:create)

    MovieService.new(fake_repo).create(title: "Akira", director: "Katsuhiro Otomo")

    expect(fake_repo).to have_received(:create).with(title: "Akira",
                                                     director: "Katsuhiro Otomo")
  end

  it "raises a creation error when the repo fails to create a record" do
    fake_repo = instance_double(MovieRepository)
    allow(fake_repo).to receive(:create).and_raise(MovieRepository::MissingArgumentError)

    expect {
      MovieService.new(fake_repo).create(title: "Paprika")
    }.to raise_error(MovieService::MovieCreationError)
  end

end
