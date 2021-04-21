struct MovieResonse: Codable {
    let id: Int
    let budget: Int
    let backdrop_path: String?
    let original_language: String

    struct Genres: Codable {
        let name: String
    }
    let genres: [Genres]

    let overview: String
    let original_title: String
}
