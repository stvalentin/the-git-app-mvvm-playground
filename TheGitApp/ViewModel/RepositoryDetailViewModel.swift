import Foundation
import MarkdownKit

class RepositoryDetailViewModel {
    let repository: Repository
    private let apiClient: ApiProtocol
    var readmeContent: NSAttributedString?
    
    var resultFetched: (()->())?
    
    init(apiClient: ApiProtocol, repository: Repository) {
        self.repository = repository
        self.apiClient = apiClient
    }
    
    private func getReadme() {
        apiClient.getReadmeRequest(repository: repository) { (result) in
            let markdownParser = MarkdownParser()
            self.readmeContent = markdownParser.parse(result ?? "Readme file not present")
            
            self.resultFetched?()
        }
    }
    
    func fetch() {
        self.getReadme()
    }
}
