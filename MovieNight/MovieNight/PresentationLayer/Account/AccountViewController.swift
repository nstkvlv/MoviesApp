import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var savedMoviesCollectionView: UICollectionView!

    private let viewModel: AccountViewModelProtocol = AccountViewModel()

    var savedMovies: [MovieResonse] {
        viewModel.savedMovies.reversed()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account"
        setupMovieCollectionView()
        viewModel.fetchSavedMovies {
            self.savedMoviesCollectionView.reloadData()
        }
    }

    private func setupMovieCollectionView() {
        savedMoviesCollectionView?.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
        savedMoviesCollectionView.delegate = self
        savedMoviesCollectionView.dataSource = self
        savedMoviesCollectionView.register(UINib(nibName: "PopularMovieCell", bundle: nil),
                                     forCellWithReuseIdentifier: "PopularMovieCell")
    }

}

extension AccountViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        savedMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMovieCell", for: indexPath) as? PopularMovieCell else { return UICollectionViewCell() }
        cell.configureMovie(info: savedMovies[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "MoviePresentation", bundle: nil).instantiateViewController(withIdentifier: "MoviePresentationViewController") as? MoviePresentationViewController else { return }
        vc.movieId = String(savedMovies[indexPath.row].id)
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }

}

extension AccountViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 50,
                      height: view.frame.height / 4)
    }
}
