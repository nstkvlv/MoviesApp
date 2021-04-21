//
//  MovieImageManager.swift
//  MovieNight
//
//  Created by Анастасия Ковалева on 16.03.21.
//

import Foundation.NSURL
import UIKit.UIImage
import Kingfisher

final class MovieImageManager: BaseNetworkManager {
    override var host: Host {
        return .imageHost
    }
}

extension MovieImageManager: MovieImageManagerProtocol {
    func createMovieImageUrl(imagePath: String) -> URL? {
        createUrl(host: host,
                  path: HTTPNetworkRoute.movieImage.rawValue + imagePath,
                  q: [])
    }
}
