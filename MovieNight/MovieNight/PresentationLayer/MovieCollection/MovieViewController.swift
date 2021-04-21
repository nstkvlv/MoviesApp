//
//  ViewController.swift
//  MovieNight
//
//  Created by Анастасия Ковалева on 15.03.21.
//

import UIKit

final class MovieViewController: UIViewController {
    
    @IBOutlet private var movieCollectionView: UICollectionView!
    
    private let viewModel: MovieViewModelProtocol = MovieViewModel()
    private let accountButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchMovies()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        accountButton.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        accountButton.isHidden = true
    }
    
    private func setupUI() {
        setupNavigationBar()
        setupMovieCollectionView()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Popular Movies"
        addAccountButton()
    }

    private func addAccountButton() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        accountButton.addTarget(self, action: #selector(openAccount), for: .touchUpInside)
        accountButton.tintColor = .gray
        accountButton.setImage(UIImage(named: "account"), for: .normal)
        accountButton.layer.masksToBounds = true
        accountButton.layer.cornerRadius = 20
        navigationBar.addSubview(accountButton)
        accountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accountButton.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -20),
            accountButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -8),
            accountButton.widthAnchor.constraint(equalToConstant: 40),
            accountButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupMovieCollectionView() {
        movieCollectionView?.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(
            UINib(nibName: "PopularMovieCell", bundle: nil),
            forCellWithReuseIdentifier: "PopularMovieCell"
        )
        movieCollectionView.register(
            FiltersView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: FiltersView.self)
        )
    }
    
    private func fetchMovies() {
        viewModel.fetchMovies() {
            self.movieCollectionView.reloadData()
        }
    }

    @IBAction private func openAccount() {
        guard let vc = UIStoryboard(name: "Account", bundle: nil).instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMovieCell", for: indexPath) as? PopularMovieCell else { return UICollectionViewCell() }
        cell.configurePopularMovie(info: viewModel.movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "MoviePresentation", bundle: nil).instantiateViewController(withIdentifier: "MoviePresentationViewController") as? MoviePresentationViewController else { return }
        vc.movieId = String(viewModel.movies[indexPath.row].id)
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: FiltersView.self), for: indexPath) as? FiltersView
            headerView?.filters = viewModel.filters
            return headerView ?? UICollectionReusableView()
        }
        return UICollectionReusableView()
    }

    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//
//        if offsetY > (scrollView.contentSize.height - scrollView.frame.size.height),
//           !viewModel.isEventsLoading {
//            fetchMovies()
//        }
//    }
}

extension MovieViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 15, height: 300)
    }

}
