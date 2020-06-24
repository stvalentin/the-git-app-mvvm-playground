import Foundation

struct Owner: Decodable {
    let login: String
}

struct Repository: Decodable {
    let apiUrl: String
    let createdAt: String
    let description: String?
    let forksCount: Int
    let htmlUrl: String
    let name: String
    let owner: Owner
    let updatedAt: String
    let watchersCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case apiUrl = "full_name"
        case createdAt = "created_at"
        case description
        case forksCount = "forks_count"
        case htmlUrl = "html_url"
        case name
        case owner
        case updatedAt = "updated_at"
        case watchersCount = "watchers_count"
    }
}
