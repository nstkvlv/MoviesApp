import Foundation.NSURL

struct MovieInfoRequest {
    private var apiKey = Tokens.apiKey

    private var apiKeyQueryItem: URLQueryItem {
        URLQueryItem(name: "api_key", value: apiKey)
    }

    var body: [URLQueryItem] {
        return [apiKeyQueryItem]
    }
}
