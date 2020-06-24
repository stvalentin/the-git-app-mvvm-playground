import Foundation

struct RepositoryReadMe: Decodable {
    let downloadUrl: String

    private enum CodingKeys: String, CodingKey {
        case downloadUrl = "download_url"
    }
}
