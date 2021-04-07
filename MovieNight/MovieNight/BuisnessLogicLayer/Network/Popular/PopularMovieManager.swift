//
//  PopularMovieManager.swift
//  MovieNight
//
//  Created by Анастасия Ковалева on 15.03.21.
//

import Foundation.NSURL
import Alamofire
import UIKit.UIImage

final class PopularMovieManager: BaseNetworkManager {
        
    private func createPopularMoviesUrl(page: Int) -> URL? {
        createUrl(host: host,
                  path: HTTPNetworkRoute.popularMovie.rawValue,
                  q: PopularMoviesRequest(page: page).body)
    }
}

extension PopularMovieManager: PopularMovieManagerProtocol {
    func fetchPopularMovies(page: Int, with completion: @escaping ([PopularMovie]) -> Void) {
        guard let url = createPopularMoviesUrl(page: page) else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            AF.request(url).responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data,
                          let popularMoviesResponse = try? JSONDecoder().decode(PopularMoviesResponse.self, from: data)
                    else { return }
                    DispatchQueue.main.async {
                        completion(popularMoviesResponse.results)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
