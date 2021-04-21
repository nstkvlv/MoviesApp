//
//  PopulerMovieManagerProtocol.swift
//  MovieNight
//
//  Created by Анастасия Ковалева on 16.03.21.
//

typealias PopularMovie = PopularMoviesResponse.Result

protocol PopularMovieManagerProtocol {
    func fetchPopularMovies(page: Int, with completion: @escaping ([PopularMovie]) -> Void)
}
