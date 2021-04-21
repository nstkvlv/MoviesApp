//
//  MoviePresentationViewController.swift
//  MovieNight
//
//  Created by Анастасия Ковалева on 16.03.21.
//

import UIKit

class MoviePresentationViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var originalLanguage: UILabel!
    @IBOutlet weak var genersLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!

    private let viewModel: MoviePresentationViewModelProtocol = MoviePresentationViewModel()

    var movieId: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMovieInfo(id: movieId) { movie in
            self.configure(with: movie)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                           target: self,
                                                           action: #selector(doneTapped))

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                           target: self,
                                                           action: #selector(saveMovie))
    }
    
    private func configure(with movie: MovieResonse) {
        navigationController?.navigationBar.prefersLargeTitles = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        overviewTextView.text = movie.overview
        titleLabel.text = movie.original_title
        imageView.kf.setImage(with: viewModel.getMovieImageURL(path:movie.backdrop_path))
    }

    @IBAction private func doneTapped() {
        dismiss(animated: true)
    }

    @IBAction private func saveMovie() {
        viewModel.save { result in
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            let alert = UIAlertController(title: result, message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
