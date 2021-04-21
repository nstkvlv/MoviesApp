import Foundation.NSURL

enum Scheme: String {
    case https
    case http
}

enum Host: String {
    case movieDBApi = "api.themoviedb.org"
    case imageHost = "image.tmdb.org"
}

class BaseNetworkManager {
    
    var scheme: Scheme { return .https }
    
    var host: Host { return .movieDBApi }
    
    var headers: [String: String] {
        return [:]
    }
    
    func createRequest(url: URL, with headers: [String: String]?) -> URLRequest {
        var request = URLRequest(url: url)
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        return request
    }
    
    func createUrl(host: Host, path: String, q: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme.rawValue
        urlComponents.host = host.rawValue
        urlComponents.path = path
        urlComponents.queryItems = q
        
        if urlComponents.url == nil {
            return URL(string: "")
        }
        guard let url = urlComponents.url else { return URL(string: "")}
        return URL(string: url.absoluteString)
    }
}
