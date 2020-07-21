import Foundation

class RepositoryListViewModel {

    private var apiClient: ApiProtocol
    var items = Box<SearchResults?>(nil)
    var error = Box<ErrorResult?>(nil)
    
        
    var selectedRepository: Repository?
    
    init(apiClient: ApiProtocol) {
        self.apiClient = apiClient;
    }
    
    func fetch(searchQuery: String) {
        self.apiClient.getSearchRequest(searchQuery: searchQuery) { result in
            switch result {
            case .success(let result):
                self.items.value = result
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
