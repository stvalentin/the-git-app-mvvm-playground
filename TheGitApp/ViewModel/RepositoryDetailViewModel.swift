import Foundation
import MarkdownKit

class RepositoryDetailViewModel {
    let repository: Repository
    private let apiClient: ApiProtocol
    
    var error = Box<ErrorResult?>(nil)
    var readmeContent = Box<NSAttributedString?>(nil)
    
    init(apiClient: ApiProtocol, repository: Repository) {
        self.repository = repository
        self.apiClient = apiClient
    }
    
    private func getReadme() {
        apiClient.getReadmeRequest(repository: repository) { (result) in
            let markdownParser = MarkdownParser()
            self.readmeContent.value = markdownParser.parse(result ?? "Readme file not present")
        }
    }
    
    func fetch() {
        self.getReadme()
    }
}
