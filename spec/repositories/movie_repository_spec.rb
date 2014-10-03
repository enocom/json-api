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

  it "ignores the ID attribute when persisting movies" do
    movie = MovieEntity.new(
      id: 999,
      :title => "Rashomon",
      :director => "Kurozawa Akira"
    )

    result = repository.add(movie)

    expect(result.entity.id).not_to eq 999
  end

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

    result = repository.find_by_id(created_movie.id)

    expect(result.class).to eq StoreResult
    expect(result.success?).to eq true
    expect(result.entity.title).to eq "Rear Window"
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

    result = repository.update(movie_with_updated_title)

    expect(persisted_movie.reload.title).to eq "North by Northwest"

    expect(result.class).to eq StoreResult
    expect(result.success?).to eq true
    expect(result.entity.title).to eq "North by Northwest"
  end

  it "deletes movies from the database" do
    persisted_movie = MovieDao.create(
      :title => "Rear Window",
      :director => "Alfred Hitchcock"
    )

    result = repository.destroy(persisted_movie.id)

    expect(result.class).to eq StoreResult
    expect(result.success?).to eq true
    expect(result.entity).to be_nil

    expect(MovieDao.count).to be_zero
  end

  describe "error handling" do
    it "returns errors when finding a non-existent record" do
      result = repository.find_by_id(999)

      expect(result.class).to eq StoreResult
      expect(result.success?).to eq false
      expect(result.entity).to be_nil
      expect(result.errors).to eq([{field: "base", message: "A record with 'id'=999 was not found."}])
    end

    it "returns errors when updating a non-existent record" do
      result = repository.update(MovieEntity.new(id: 999))

      expect(result.class).to eq StoreResult
      expect(result.success?).to eq false
      expect(result.entity).to be_nil
      expect(result.errors).to eq([{field: "base", message: "A record with 'id'=999 was not found."}])
    end

    it "returns false when deleting a non-existent record" do
      result = repository.destroy(999)

      expect(result.class).to eq StoreResult
      expect(result.success?).to eq false
      expect(result.entity).to be_nil
      expect(result.errors).to eq([{field: "base", message: "A record with 'id'=999 was not found."}])
    end

    it "returns validation errors for an invalid update" do
      movie = MovieDao.create(
        :title => "The Empire Strikes Back",
        :director => "George Lucas"
      )

      invalid_update = MovieEntity.new(
        :id => movie.id,
        :title => "The Empire Strikes Again"
      )

      result = repository.update(invalid_update)

      expect(result.class).to eq StoreResult
      expect(result.success?).to eq false
      expect(result.entity).to be_nil
      expect(result.errors).to match_array([{field: "director",
                                             message: "can't be blank"}])
    end

    it "returns validation errors when creating an invalid record" do
      invalid_record = MovieEntity.new(
        :title => "The Empire Strikes Again" # No director
      )

      result = repository.add(invalid_record)

      expect(result.class).to eq StoreResult
      expect(result.success?).to eq false
      expect(result.entity).to be_nil
      expect(result.errors).to match_array([{field: "director",
                                             message: "can't be blank"}])
    end
  end

end
