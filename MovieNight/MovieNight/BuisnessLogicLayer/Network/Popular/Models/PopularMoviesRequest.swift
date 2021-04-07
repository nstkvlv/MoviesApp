//
//  TopRatedMoviesRequest.swift
//  MovieNight
//
//  Created by Анастасия Ковалева on 15.03.21.
//

import Foundation.NSURL

struct PopularMoviesRequest {
    private var apiKey = Tokens.apiKey
    private let language = "en-US"
    private let page: Int
    
    init(page: Int) {
        self.page = page
    }
    
    private var apiKeyQueryItem: URLQueryItem {
        URLQueryItem(name: "api_key", value: apiKey)
    }
    
    private var languageQueryItem: URLQueryItem {
        URLQueryItem(name: "language", value: language)
    }
    
    private var pageQueryItem: URLQueryItem {
        URLQueryItem(name: "page", value: "\(page)")
    }
    
    var body: [URLQueryItem] {
        return [apiKeyQueryItem, languageQueryItem, pageQueryItem]
    }
}
