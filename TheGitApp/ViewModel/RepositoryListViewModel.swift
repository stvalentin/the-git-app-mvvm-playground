import Foundation

class RepositoryListViewModel {
    
    var list = [Repository]()
    
    private var apiClient: ApiProtocol
    
    var resultFetched: (()->())?
    
    var numberOfItems: Int {
        return list.count
    }
    
    var selectedRepository: Repository?
    
    init(apiClient: ApiProtocol) {
        self.apiClient = apiClient;
    }
    
    func fetch(searchQuery: String) {
        self.apiClient.getSearchRequest(searchQuery: searchQuery) { (result) in
            guard let items = result?.items else {
                print("On error")
                return
            }
            self.list = items
            self.resultFetched?()
        }
    }
}
