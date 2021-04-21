import Foundation.NSURL

protocol MoviePresentationViewModelProtocol {
//    var movie: MovieResonse? { get }
    func getMovieImageURL(path: String?) -> URL?
    func save(with completion: @escaping (String) -> Void)
    func fetchMovieInfo(id: String, with completion: @escaping (MovieResonse) -> Void)
}

final class MoviePresentationViewModel {
    private let coreDataHelper = CoreDataHelper()
    private let imageManager: MovieImageManagerProtocol = MovieImageManager()
    private let movieInfoManager: MovieInfoManagerProtocol = MovieInfoManager()

    var movie: MovieResonse?
}

extension MoviePresentationViewModel: MoviePresentationViewModelProtocol {

    func save(with completion: @escaping (String) -> Void) {
        guard let movie = movie else { return }
        coreDataHelper.save(movie) { result in
            completion(result)
        }
    }

    func fetchMovieInfo(id: String, with completion: @escaping (MovieResonse) -> Void) {
        movieInfoManager.fetchMovieInfo(id: id) { movie in
            self.movie = movie
            completion(movie)
        }
    }

    func getMovieImageURL(path: String?) -> URL? {
        return imageManager.createMovieImageUrl(imagePath: path ?? "")
    }
}
