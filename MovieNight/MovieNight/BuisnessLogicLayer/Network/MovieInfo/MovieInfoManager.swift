import Alamofire

final class MovieInfoManager: BaseNetworkManager {

    private func createMovieInfoUrl(movieId: String) -> URL? {
        createUrl(host: host,
                  path: HTTPNetworkRoute.movieInfo.rawValue + movieId,
                  q: MovieInfoRequest().body)
    }

}

extension MovieInfoManager: MovieInfoManagerProtocol {
    func fetchMovieInfo(id: String, with completion: @escaping (MovieResonse) -> Void) {
        guard let url = createMovieInfoUrl(movieId: id) else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            AF.request(url).responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data,
                          let movieResponse = try? JSONDecoder().decode(MovieResonse.self, from: data)
                    else { return }
                    DispatchQueue.main.async {
                        completion(movieResponse)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
