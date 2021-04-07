//
//  TopRatedMoviesResponse.swift
//  MovieNight
//
//  Created by Анастасия Ковалева on 15.03.21.
//

struct PopularMoviesResponse: Decodable {
    struct Result: Decodable {
        let id: Int
        let title: String
        let originalLanguage: String
        let posterPath: String?
        let backdropPath: String?
        let voteAverage: Double
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case title = "title"
            case originalLanguage = "original_language"
            case posterPath = "poster_path"
            case backdropPath = "backdrop_path"
            case voteAverage = "vote_average"
        }
    }
    let results: [Result]
}
