import Foundation

struct SearchResults: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    var items: [Repository]
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
