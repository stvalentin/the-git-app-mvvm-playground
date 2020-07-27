import Foundation

protocol ApiProtocol {
    func getSearchRequest(searchQuery: String, page: Int, completion: @escaping (Result<SearchResults, ErrorResult>) -> Void)
    func getReadmeRequest(repository: Repository, completion: @escaping(String?) -> Void)
}

enum ErrorResult: Error {
  case invalidData
}

extension ErrorResult: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return NSLocalizedString(
                "Error on requesting information",
                comment: ""
            )
        }
    }
}
