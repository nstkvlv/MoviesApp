import CoreGraphics

protocol MovieViewModelProtocol {
    var movies: [PopularMovie] { get }
    var sizes: [CGFloat] { get }
    var isEventsLoading: Bool { get }
    var filters: [Filter] { get }
    func fetchMovies(with completion: @escaping () -> Void)
}

final class MovieViewModel {
    private let popularMovieManager: PopularMovieManagerProtocol = PopularMovieManager()
    private var popularMovies = [PopularMovie]()
    private var isLoading = false
    private var page = 0
    private var filtersArray = [Filter(name: "Popular", color: .orange),
                                Filter(name: "Trending", color: .red),
                                Filter(name: "Upcoming", color: .blue),
                                Filter(name: "Top Rated", color: .green),
                                Filter(name: "Latest", color: .black)]
}

extension MovieViewModel: MovieViewModelProtocol {
    var movies: [PopularMovie] {
        return popularMovies
    }
    
    var sizes: [CGFloat] {
        return [300, 400, 300, 400, 350, 450]
    }
    
    var isEventsLoading: Bool {
        return isLoading
    }

    var filters: [Filter] {
        return filtersArray
    }

    func fetchMovies(with completion: @escaping () -> Void) {
        self.page += 1
        isLoading = true
        popularMovieManager.fetchPopularMovies(page: page) { popularMovies in
            self.popularMovies = popularMovies
            self.popularMovies.sort { $0.voteAverage > $1.voteAverage }
            self.isLoading = false
            completion()
        }
    }
}
