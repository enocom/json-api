[
  { title: "Seven Samurai", director: "Akira Kurozawa" },
  { title: "Dune", director: "Alan Smithee" },
  { title: "2001", director: "Stanley Kubrick" }
].each do |movie_info|
  MovieManager::MovieRepo.persist(title:    movie_info[:title],
                                  director: movie_info[:director])
end
