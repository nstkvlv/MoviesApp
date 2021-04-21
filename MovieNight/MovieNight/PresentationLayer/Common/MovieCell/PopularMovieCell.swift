//
//  PopularMovieCollectionViewCell.swift
//  MovieNight
//
//  Created by Анастасия Ковалева on 16.03.21.
//

import UIKit.UICollectionViewCell
import Kingfisher

class PopularMovieCell: UICollectionViewCell {
    
    @IBOutlet private weak var rateView: UIView!
    @IBOutlet private var rateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    
    private let imageManager: MovieImageManagerProtocol = MovieImageManager()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = 10
    }
    
    func configurePopularMovie(info: PopularMovie) {
        titleLabel.isHidden = true
        rateLabel.text = String(info.voteAverage)
        guard let imagePath = info.posterPath,
              let imageUrl = imageManager.createMovieImageUrl(imagePath: imagePath) else { return }
        imageView.kf.setImage(with: imageUrl)
    }

    func configureMovie(info: MovieResonse) {
        imageView.contentMode = .scaleToFill
        titleLabel.text = info.original_title
        rateView.isHidden = true 
        rateLabel.isHidden = true
        guard let imagePath = info.backdrop_path,
              let imageUrl = imageManager.createMovieImageUrl(imagePath: imagePath) else { return }
        imageView.kf.setImage(with: imageUrl)
    }
}
