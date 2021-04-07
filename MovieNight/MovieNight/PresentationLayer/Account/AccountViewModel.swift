protocol AccountViewModelProtocol {
    var savedMovies: [MovieResonse] { get }

    func fetchSavedMovies(with completion: @escaping () -> Void)
}

final class AccountViewModel {
    private let coreDataHelper = CoreDataHelper()

    var savedMovies = [MovieResonse]()
}

extension AccountViewModel: AccountViewModelProtocol {

    func fetchSavedMovies(with completion: @escaping () -> Void) {
        coreDataHelper.fetchMovies { response in
            self.savedMovies = response
            completion()
        }
    }
}
