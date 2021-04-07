//
//  MovieImageManagerProtocol.swift
//  MovieNight
//
//  Created by Анастасия Ковалева on 16.03.21.
//

import UIKit.UIImage

protocol MovieImageManagerProtocol {
    func createMovieImageUrl(imagePath: String) -> URL?
}
