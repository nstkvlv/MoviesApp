protocol MovieInfoManagerProtocol {
    func fetchMovieInfo(id: String, with completion: @escaping (MovieResonse) -> Void)
}
